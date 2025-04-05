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
    files=$(git diff --cached --name-only -- $filetype "**/$filetype")
else
    files=$(git diff --cached --name-only)
fi
filtered=$files
# Filtering files if exclude pattern is provided
if [[ -n "$exclude" ]]; then
    filtered=($(echo "${files}" | grep -v -E "$exclude"))
fi
# Format the files
for file in "${filtered}"; do
    echo "Formatting ${file}"
    "${command[@]}" "${file}"
done
