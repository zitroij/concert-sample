#!/usr/bin/env bash

if test -z "$IMAGE"; then
   IMAGE="concert-sample"
fi

if test -z "$TAG"; then
   TAG="sample"
fi


# shellcheck disable=SC2086
docker build -f Dockerfile -t ${IMAGE}:${TAG}


DIGEST="$(docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE}" | awk -F@ '{print $2}')"


#docker push "${IMAGE}"
