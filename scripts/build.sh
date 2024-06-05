#!/usr/bin/env bash

. demo_build_envs.variables

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

if test -z "$IMAGE_NAME"; then
   IMAGE_NAME="concert-sample"
fi

if test -z "$IMAGE_TAG"; then
   IMAGE_TAG="sample"
fi

# shellcheck disable=SC2086
docker build -f $sourcecodedir/Dockerfile -t ${IMAGE_NAME}:${IMAGE_TAG} 


IMAGE_DIGEST="$(docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_NAME}:${IMAGE_TAG}" | awk -F@ '{print $2}')"

echo "EXPORT IMAGE_DIGEST=${IMAGE_DIGEST}" >> demo_build_envs.variables

