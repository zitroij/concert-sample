#!/bin/bash

OUTPUT_FILENAME="cyclonedx-sbom.json"


echo "${SRC_PATH}" > /dev/null
docker exec -it ibm-concert-toolkit bash -c 'cdxgen.sh --'
echo > /dev/null

