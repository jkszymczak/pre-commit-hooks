#!/usr/bin/env bash

# Capture the command to run (everything up to the first file)
cmd=()
files=()

# Loop through all arguments
for arg in "$@"; do
    if [[ -f "$arg" || "$arg" == "-"* && -f "${arg#-}" ]]; then
        files+=("$arg")
    else
        cmd+=("$arg")
    fi
done

# Run the command for each file
for file in "${files[@]}"; do
    "${cmd[@]}" "$file"
    git add $file
done

