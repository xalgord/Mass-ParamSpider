#!/bin/bash

# Path to the ParamSpider script
PARAMSPIDER_PATH="paramspider.py"

# Input file containing the list of domains
DOMAINS_FILE="domains.txt"

# Output directory for storing the individual domain results
OUTPUT_DIR="output"

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
  domain=$(echo "$domain" | awk -F/ '{print $3}')
  output_dir="$OUTPUT_DIR/$domain"
  mkdir -p "$output_dir"

  echo -e "${YELLOW}Running ParamSpider on $domain...${NC}"
  "$PARAMSPIDER_PATH" -d "$domain" --level high -o "$output_dir/output.txt"
  if [ -s "$output_dir/output.txt" ]; then
    echo -e "${GREEN}ParamSpider completed for $domain. Output saved in $output_dir${NC}"
  else
    echo -e "${RED}No output file generated for $domain.${NC}"
  fi
}

# Read the domains file line by line and run ParamSpider for each domain
while IFS= read -r domain || [[ -n "$domain" ]]; do
  run_paramspider "$domain"
done < "$DOMAINS_FILE"

# Combine the individual domain outputs into a single file
find "$OUTPUT_DIR" -name "output.txt" -exec cat {} + > "$COMBINED_OUTPUT_FILE"
echo -e "${GREEN}Combined output saved in $COMBINED_OUTPUT_FILE${NC}"
