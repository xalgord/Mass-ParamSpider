#!/bin/bash

# Path to the ParamSpider script
PARAMSPIDER_PATH="bbtools/ParamSpider/paramspider.py"

# Input file containing the list of domains
DOMAINS_FILE="domains.txt"

# Output file for storing the combined results
OUTPUT_FILE="combined_output.txt"

# Function to run ParamSpider on a single domain
run_paramspider() {
  domain="$1"
  output_file="${domain}_output.txt"
  
  echo "Running ParamSpider on $domain..."
  python3 "$PARAMSPIDER_PATH" -d "$domain" --level high -o "$output_file"
  echo "ParamSpider completed for $domain. Output saved in $output_file"
}

# Read the domain list file line by line and run ParamSpider for each domain
while IFS= read -r domain || [[ -n "$domain" ]]; do
  run_paramspider "$domain"
done < "$DOMAINS_FILE"

# Combine the individual domain outputs into a single file
cat output/*_output.txt > "$OUTPUT_FILE"
echo "Combined output saved in $OUTPUT_FILE"
