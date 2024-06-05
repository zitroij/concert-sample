#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables
source ${VARIABLES_FILE}

BUILD_FILENAME=${sourcecodedir}/concert_data/build-config.yaml

touch ${BUILD_FILENAME}
cat > ${BUILD_FILENAME} << EOD
concert:
    build:
      app_name: ${APP_NAME}
      number: ${BUILD_NUMBER}
      version: ${APP_VERSION}
      repository:
        name: ${REPO_NAME}
        url: ${REPO_URL}
        commit_sha: ${REPO_COMMIT_SHA}
        branch: ${REPO_BRANCH}
      image:
        name: ${IMAGE_NAME}
        tag: ${IMAGE_TAG}
        digest: ${IMAGE_DIGEST}
EOD


OUTPURDIR=${sourcecodedir}/concert_data

OUTPUT_FILENAME="$REPO_NAME-$BUILD_NUMBER-sbom.json"
CONFIG_FILE="/data/out/build-config.yaml"
CODE_SCAN_COMMAND="/app/gen-build-inventory-sbom.sh --build-config ${CONFIG_FILE} --output-file ${OUTPUT_FILENAME}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPURDIR}:/data/out localhost/ibm-concert-toolkit:v1 bash -c "${CODE_SCAN_COMMAND}"

