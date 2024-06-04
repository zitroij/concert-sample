#!/bin/bash

OUTPUT_FILENAME="cyclonedx-sbom.json"


echo "${SRC_PATH}" 
docker exec -it ibm-concert-toolkit bash -c 'syft.sh --'


