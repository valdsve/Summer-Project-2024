#!/bin/bash

# Loop through each pair of fastq.gz files (assuming paired-end data)
for file1 in *_1.fastq.gz; do
  # Extract filename without extension
  filename="${file1%_*}"

  # Check if corresponding _2 file exists (assuming _1 and _2 naming convention)
  file2="${filename}_2.fastq.gz"
  if [[ ! -f "$file2" ]]; then
    echo "Error: Missing _2 file for $file1. Skipping..."
    continue
  fi

  # Create output directory named after the filename
  mkdir -p "$filename"

  # Run Kallisto quant with specific arguments and output directory
  kallisto quant -i Homo_sapiens.GRCh38.cdna.all.idx -o "$filename" -b 100 -t 32 "$file1" "$file2"
done