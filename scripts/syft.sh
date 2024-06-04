#!/bin/bash

OUTPUT_FILENAME_SUFFIX="sbom.json"

usage() {
    echo "Usage: $0 --images <images-comma-separated>"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --images)
            IMAGES="$2"
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

if [ -z "$IMAGES" ]; then
    echo "Error: --images <images-comma-separated> is required."

    Images require the registry prefix.

    usage
fi

IFS=',' read -r -a IMAGE_ARRAY <<< "$IMAGES"

for IMAGE in "${IMAGE_ARRAY[@]}"; do
    IMAGE_FILENAME=$(echo "$IMAGE" | tr '/' '_')
    OUTPUT_FILENAME="${IMAGE_FILENAME}-${OUTPUT_FILENAME_SUFFIX}"

    echo "Scanning image: $IMAGE"
    syft scan registry:${IMAGE} -o cyclonedx-json > $OUTPUT_FILENAME

    if [ -f "$OUTPUT_FILENAME" ]; then
        echo "SBOM has been generated successfully at $OUTPUT_FILENAME"
    else
        echo "Error: Failed to generate SBOM for image $IMAGE."
    fi
done