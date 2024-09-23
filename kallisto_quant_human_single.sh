#!/bin/bash

# Loop through each fastq.gz file
for file in *.fastq.gz; do
  # Extract filename without extension
  filename="${file%.f*}"

  # Create output directory named after the filename
  mkdir -p "$filename"

  # Run Kallisto quant with specific arguments and output directory
  kallisto quant -i Homo_sapiens.GRCh38.cdna.all.idx -o "$filename" -b 100 -t 32 --single -l 250 -s 30 "$file"
done