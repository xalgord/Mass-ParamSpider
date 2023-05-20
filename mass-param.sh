#!/bin/bash

# Path to the ParamSpider script
PARAMSPIDER_PATH="bbtools/ParamSpider/paramspider.py"

# Path to the httprobe tool
HTTPROBE_PATH="httprobe"

# Input file containing the list of domains
DOMAINS_FILE="domains.txt"

# Output directory for storing the individual domain results
OUTPUT_DIR="output"

# Output file for storing the combined results
COMBINED_OUTPUT_FILE="combined_output.txt"

# Function to run httprobe on a list of domains and remove dead URLs
run_httprobe() {
  input_file="$1"
  output_file="${input_file}_live.txt"

  echo "Running httprobe on $input_file..."
  cat "$input_file" | "$HTTPROBE_PATH" | awk -F/ '{print $3}' | sort -u > "$output_file"
  echo "httprobe completed for $input_file. Live URLs saved in $output_file"
}

# Function to run ParamSpider on a single domain
run_paramspider() {
  domain="$1"
  if [[ ! "$domain" =~ ^https?:// ]]; then
    domain="http://$domain"
  fi
  domain=$(echo "$domain" | awk -F/ '{print $3}')
  output_dir="$OUTPUT_DIR/$domain"
  mkdir -p "$output_dir"

  echo "Running ParamSpider on $domain..."
  python3 "$PARAMSPIDER_PATH" -d "$domain" --level high -o "$output_dir/output.txt"
  echo "ParamSpider completed for $domain. Output saved in $output_dir"
}

# Read the domain list file and run httprobe to remove dead URLs
run_httprobe "$DOMAINS_FILE"
LIVE_DOMAINS_FILE="${DOMAINS_FILE}_live.txt"

# Read the live domains file line by line and run ParamSpider for each domain
while IFS= read -r domain || [[ -n "$domain" ]]; do
  run_paramspider "$domain"
done < "$LIVE_DOMAINS_FILE"

# Combine the individual domain outputs into a single file
find "$OUTPUT_DIR" -name "output.txt" -exec cat {} + > "$COMBINED_OUTPUT_FILE"
echo "Combined output saved in $COMBINED_OUTPUT_FILE"
