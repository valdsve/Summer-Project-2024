#!/bin/bash

while IFS= read -r line; do
    line=$(echo "$line" | tr -d '\r')
    if [[ $line =~ ^[A-Za-z\ -]+$ ]]; then
        current_dir="${line// /_}"
        mkdir -p "$current_dir"
        output_file="${current_dir}/${current_dir}.txt"
        echo "Created directory: $current_dir"
        echo "Output file: $output_file"
    elif [[ $line =~ ^SRR ]]; then
        cp "$line" "$current_dir/"
        echo "$line" >> "$output_file"
    else
        echo "Line does not match any pattern: $line"
    fi
done < "FASTAQ_paths.txt"
