#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


OUTPUT_FILENAME="code-scancyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

echo "${SRC_PATH}" > /dev/null
docker run -it --rm -u $(id -u):$(id -g) -v $sourcecodedir:/data localhost/ibm-concert-toolkit:v1 bash -c '/app/code-scan-sbom-cdxgen.sh --src /data --out /data/concert_data'
echo > /dev/null

