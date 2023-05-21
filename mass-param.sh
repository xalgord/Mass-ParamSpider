#!/bin/bash

# Path to the ParamSpider script
PARAMSPIDER_PATH="paramspider.py"

# Input file containing the list of domains
DOMAINS_FILE="$1"

# Number of parallel jobs for curl and ParamSpider
CURL_JOBS=50
PARAMSPIDER_JOBS=10

# Output directory for storing the individual domain results
OUTPUT_DIR="$HOME/output"

# Output file for storing the combined results
COMBINED_OUTPUT_FILE="combined_output.txt"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to run ParamSpider on a single domain
run_paramspider() {
  domain="$1"
  if [[ ! "$domain" =~ ^https?:// ]]; then
    domain="http://$domain"
  fi
  domain=${domain#*//}
  output_dir="$OUTPUT_DIR/$domain"
  mkdir -p "$output_dir"

  "$PARAMSPIDER_PATH" -d "$domain" --level high -o "$output_dir/output.txt"
  if [ -s "$output_dir/output.txt" ]; then
    echo -e "ParamSpider completed for $domain.${NC}"
    echo -e "Output saved in: ${GREEN}$output_dir${NC}"
  else
    echo -e "No output file generated for $domain.${NC}"
  fi
}

# Check if the domains file exists
if [ ! -f "$DOMAINS_FILE" ]; then
  echo -e "${RED}Domains file not found.${NC}"
  exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Read the domains file line by line and check if the domains are live using curl
live_domains_file="${DOMAINS_FILE%.*}_live.txt"
echo -e "${YELLOW}Checking live domains using curl...${NC}"
cat "$DOMAINS_FILE" | parallel -j"$CURL_JOBS" --progress "curl -s -o /dev/null -w '%{http_code} {}\\n' {}" | awk '$1 >= 200 && $1 < 400 {print $2}' > "$live_domains_file"
echo -e "${GREEN}Live domains saved in $live_domains_file${NC}"

# Read the live domains file line by line and run ParamSpider for each domain in parallel
live_domains_count=$(wc -l < "$live_domains_file")
current_progress=0
echo -e "${YELLOW}Running ParamSpider on live domains...${NC}"
export -f run_paramspider  # Exporting the function for parallel execution
while IFS= read -r domain; do
  ((current_progress++))
  echo -e "\n${YELLOW}(Progress: $current_progress/$live_domains_count) Running ParamSpider on $domain...${NC}"
  run_paramspider "$domain"
done < "$live_domains_file"
echo -e "\n${GREEN}ParamSpider completed for all live domains.${NC}"

# Combine the individual domain outputs into a single file
find "$OUTPUT_DIR" -name "output.txt" -exec cat {} + > "$COMBINED_OUTPUT_FILE"
echo -e "${GREEN}Combined output saved in $COMBINED_OUTPUT_FILE${NC}"
