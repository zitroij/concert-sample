#!/bin/bash


scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

OUTPUT_FILENAME_SUFFIX="${BUILD_NUMBER}-build-vars"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

echo "${SRC_PATH}" > /dev/null
docker run -it --rm -u $(id -u):$(id -g) -v $sourcecodedir:/data localhost/ibm-concert-toolkit:v1 bash -c '/app/code-scan-sbom-cdxgen.sh --src /data --output-file ${OUTPUT_FILENAME_SUFFIX}'
echo > /dev/null

