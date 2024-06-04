#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


OUTPUT_FILENAME="code-scancyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

echo "${SRC_PATH}" > /dev/null
docker exec -it ibm-concert-toolkit bash -c 'code-scan-sbom-cdxgen.sh --src $sourcecodedir'
echo > /dev/null

