#!/bin/bash

# Path to the ParamSpider script
PARAMSPIDER_PATH="paramspider.py"

# Input file containing the list of domains
DOMAINS_FILE="$1"

# Output directory for storing the individual domain results
OUTPUT_DIR="$HOME/output"

# Output file for storing the combined results
COMBINED_OUTPUT_FILE="combined_output.txt"

# Color codes
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
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
    echo -e "${GREEN}ParamSpider completed for $domain.${NC}"
    echo -e "Output saved in: ${GREEN}$output_dir${NC}"
  else
    echo -e "${RED}No output file generated for $domain.${NC}"
  fi
}

# Check if the domains file exists
if [ ! -f "$DOMAINS_FILE" ]; then
  echo -e "${RED}Domains file not found.${NC}"
  exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Read the domains file line by line and run ParamSpider for each domain
while IFS= read -r domain; do
  echo -e "${YELLOW}Running ParamSpider on $domain...${NC}"
  run_paramspider "$domain"
done < "$DOMAINS_FILE"
echo -e "\n${GREEN}✔✔✔ ParamSpider completed for all domains.${NC}"

# Combine the individual domain outputs into a single file
find "$OUTPUT_DIR" -name "output.txt" -exec cat {} + > "$COMBINED_OUTPUT_FILE"
echo -e "${GREEN}Combined output saved in $COMBINED_OUTPUT_FILE${NC}"

# Copyright notice
echo -e "\n${BLUE}This script is written by XALGORD (https://github.com/xalgord)${NC}"
