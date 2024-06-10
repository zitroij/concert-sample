#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


sourcecodedir=$(builtin cd $scriptdir/../..; pwd)

SCAN_COMMAND="image-scan-sbom-syft.sh --images ${IMAGE_NAME}:${IMAGE_TAG}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample-src -v ${OUTPURDIR}:/toolkit-data localhost/ibm-concert-toolkit:v1 bash -c "${SCAN_COMMAND}"