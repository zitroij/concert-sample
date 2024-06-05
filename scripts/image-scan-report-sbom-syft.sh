#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


OUTPUT_FILENAME="code-scancyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)



echo "${SRC_PATH}" 
docker exec -it ibm-concert-toolkit bash -c 'syft.sh --'


echo "${SRC_PATH}" > /dev/null
docker run -it --rm -u $(id -u):$(id -g) -v $:/data localhost/ibm-concert-toolkit:v1 bash -c '/app/image-scan-sbom-syft.sh --images localhost/concert-sample'
echo > /dev/null