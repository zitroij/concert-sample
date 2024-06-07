#!/usr/bin/env bash


scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/../..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

TEMPLATE_PATH=../templates

  # generate build file
  #
source ${VARIABLES_FILE}

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"

  ###
  # upload build file
  ###

  envsubst < ${TEMPLATE_PATH}/template-build.json > ${DATA_OUT_PATH}/${OUT_FILE} 
