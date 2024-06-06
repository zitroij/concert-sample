#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

OUTPURDIR=${sourcecodedir}/concert_data
SRC_PATH=${sourcecodedir}/src

source ${VARIABLES_FILE}

OUTPUT_FILENAME="$REPO_NAME-$BUILD_NUMBER-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/..; pwd)


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

CODE_SCAN_COMMAND="code-scan-sbom-cdxgen.sh --src /data --output-file ${OUTPUT_FILENAME}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/data -v ${OUTPURDIR}:/data/out localhost/ibm-concert-toolkit:v1 bash -c "${CODE_SCAN_COMMAND}"

