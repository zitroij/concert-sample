#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


OUTPUT_FILENAME="code-scancyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

echo "${SRC_PATH}" > /dev/null
docker run -it --rm -u $(id -u):$(id -g) -v $sourcecodedir:/input localhost/ibm-concert-toolkit:v1 bash -c '/app/code-scan-sbom-cdxgen.sh --src /input --out /input/concert_data/code_scan_sbom.json'
echo > /dev/null

