#!/bin/bash

usage() {
    echo "Usage: $0 --files <sbom-json-files-comma-separated>"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --files)
            FILES="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            ;;
    esac
done

if [ -z "$FILES" ]; then
    echo "Error: --files <sbom-json-files-comma-separated> is required."
    usage
fi

IFS=',' read -r -a FILE_ARRAY <<< "$FILES"

for FILE in "${FILE_ARRAY[@]}"; do
    echo "Validating SBOM file: $FILE"
    sbom-utility validate --input-file "$FILE"

    if [ $? -eq 0 ]; then
        echo "Validation successful for $FILE"
    else
        echo "Validation failed for $FILE"
    fi
done