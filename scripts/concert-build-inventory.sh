#!/bin/bash

OUTPUT_FILENAME="cyclonedx-sbom.json"


echo "${SRC_PATH}" > /dev/null
docker run -it --rm -u $(id -u):$(id -g) -v $sourcecodedir/concert_data:/input ibm-concert-toolkit bash -c 'cdxgen.sh --'
echo > /dev/null

