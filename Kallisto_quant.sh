Kallisto_quant

#!/bin/bash

# Define directories
directories=("Human_Paired_Transcripts" "Human_Single_Transcripts" "Mouse_Paired_Transcripts" "Mouse_Single_Transcripts")

# Loop through directories
for directory in "${directories[@]}"; do
  # Change directory
  cd "$directory"

  # Script name pattern (adjust as needed)
  script_pattern="kallisto_*.sh"

  # Find script matching the pattern
  script_to_run=$(find . -maxdepth 1 -type f -name "$script_pattern")

  # Check if script is found
  if [[ -f "$script_to_run" ]]; then
    # Execute the script
    ./"$script_to_run"
  else
    echo "Warning: No script matching pattern '$script_pattern' found in $directory"
  fi

  # Move back to the original directory
  cd ..
done

echo "Kallisto quant completed for all directories (with scripts found)."
