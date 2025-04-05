#!/usr/bin/env bash

OPTIND=1
filetype=""
exclude=""
include=""

while getopts "t:e:i:h" arg; do
    case $arg in
        t)
            filetype=$OPTARG
            ;;

        e)
            exclude=$OPTARG
            ;;

        i)
            include=$OPTARG
            ;;
    esac
done

shift $((OPTIND - 1))
command=$@

# Ensure the filetype is correctly expanded and used
if [[ -n "$filetype" ]]; then
    # Expanding glob pattern
    echo "Expanding glob pattern..."
    files=$(git diff --cached --name-only -- $filetype "**/$filetype")
    echo "Files found: $files"
else
    files=$(git diff --cached --name-only)
    echo "All staged files: $files"
fi
filtered=$files
# Filtering files if exclude pattern is provided
if [[ -n "$exclude" ]]; then
    echo "Filtering files with exclude pattern: $exclude"
    filtered=($(echo "${files}" | grep -v -E "$exclude"))
    echo "Files after filter: ${files}"
fi

# Debugging: Output final list of files to format
echo "Final files to format: ${filtered}"

# Format the files
for file in "${filtered}"; do
    echo "Formatting ${file}"
    eval "${command[@]} ${file}"
done
