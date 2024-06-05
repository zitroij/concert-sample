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


#echo "${SRC_PATH}" > /dev/null
#docker run -it --rm -u $(id -u):$(id -g) -v $sourcecodedir/concert_data:/input ibm-concert-toolkit bash -c 'cdxgen.sh --'
#echo > /dev/null

