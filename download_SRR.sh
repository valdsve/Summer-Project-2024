#!/bin/bash

# List of directories to process
directories=("Human_Paired_Transcripts" "Human_Single_Transcripts" "Mouse_Paired_Transcripts" "Mouse_Single_Transcripts")

# Define the file to log failed SRR IDs
failed_log="failed_srr.log"

# Clear the failed SRR log file
> "$failed_log"

# Ensure required SRA Toolkit commands are available
for cmd in prefetch fasterq-dump; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd command not found. Please ensure it is installed and in your PATH."
        exit 1
    fi
done

# Function to process SRR files in a given directory
process_srr_directory() {
    local dir=$1

    echo "Processing directory: $dir"
    
    # Construct the SRR text file path inside the directory
    local srr_file="${dir}/${dir}.txt"
    
    # Check if the SRR text file exists
    if [[ -f "$srr_file" ]]; then
        # Read SRR numbers from the file and process them
        while IFS= read -r srr; do
            echo "Processing SRR ID: $srr"
            
            # Prefetch the SRR file
            echo "$(date) - Prefetching $srr..."
            if ! prefetch -O "$dir" "$srr" 2>>"$dir/error.log"; then
                echo "Error: Failed to prefetch $srr. Check error log."
                echo "$(date) - Failed to prefetch $srr" >> "$failed_log"
                continue
            fi

            # The SRA file will be located in $dir/srr
            local sra_file="${dir}/${srr}/${srr}.sra"

            # Run fasterq-dump on the prefetched file
            echo "$(date) - Running fasterq-dump for $srr..."
            if [[ "$dir" == *"Paired"* ]]; then
                if ! fasterq-dump --split-files --outdir "$dir" "$sra_file" 2>>"$dir/error.log"; then
                    echo "Error: Failed to run fasterq-dump for $srr. Check error log."
                    echo "$(date) - Failed to run fasterq-dump on $srr" >> "$failed_log"
                fi
            else
                if ! fasterq-dump --outdir "$dir" "$sra_file" 2>>"$dir/error.log"; then
                    echo "Error: Failed to run fasterq-dump for $srr. Check error log."
                    echo "$(date) - Failed to run fasterq-dump on $srr" >> "$failed_log"
                fi
            fi

            echo "Finished processing $srr."

        done < "$srr_file"
    else
        echo "File $srr_file does not exist. Skipping directory $dir."
    fi
}

# Loop through each directory and process them one by one
for dir in "${directories[@]}"; do
    process_srr_directory "$dir"
done

echo "Processing complete. Check $failed_log for any failed SRR IDs."
