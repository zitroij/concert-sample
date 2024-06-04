#!/bin/bash

OUTPUT_FILENAME="build-sbom.json"

usage() {
    echo "Usage: $0 --src <path-to-source-code>"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --src)
            SRC_PATH="$2"
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

if [ -z "$SRC_PATH" ]; then
    echo "Error: --src <path-to-source-code> is required."
    usage
fi

if [ ! -d "$SRC_PATH" ]; then
    echo "Error: Directory $SRC_PATH does not exist."
    exit 1
fi

pushd "${SRC_PATH}" > /dev/null
cdxgen -r -o "${OUTPUT_FILENAME}" --validate
popd > /dev/null

if [ -f "${SRC_PATH}/${OUTPUT_FILENAME}" ]; then
    echo "SBOM has been generated successfully at ${SRC_PATH}/${OUTPUT_FILENAME}"
else
    echo "Error: Failed to generate SBOM."
    exit 1
fi