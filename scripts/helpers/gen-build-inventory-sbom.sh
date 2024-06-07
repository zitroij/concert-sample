#!/usr/bin/env bash




TEMPLATE_PATH=../templates
[ -z "$DATA_OUT_PATH" ] && DATA_OUT_PATH="/toolkit-data"

usage() {
    echo "Usage: $0 --build-config <path-to-config-file> --output-file <output-file>"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --build-config)
            CONFIG="$2"
            shift 2
            ;;
        --output-file)
            OUT_FILE="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            ;;
    esac
done

if [ -z "$CONFIG" ]; then
    echo "Error: --build-config <path-to-config-file> is required."
    usage
fi

if [ -z "$OUT_FILE" ]; then
    echo "Error: --output-file <output-file> is required."
    usage
fi

if [ ! -f "$CONFIG" ]; then
    echo "Error: File $CONFIG does not exist."
    exit 1
fi

  # generate build file
  #

export APP_NAME=$(yq e '.concert.build.app_name' $CONFIG)
echo "Application Name: $APP_NAME"

export BUILD_NUMBER=$(yq e '.concert.build.number' $CONFIG)
echo "Build Bumber: $BUILD_NUMBER"

export APP_VERSION=$(yq e '.concert.build.version' $CONFIG)
echo "Application Version: $APP_VERSION"

export REPO_NAME=$(yq e '.concert.build.repository.name' $CONFIG)
echo "Repository Name: $REPO_NAME"

export REPO_URL=$(yq e '.concert.build.repository.url' $CONFIG)
echo "Repository Url: $appREPO_URL_name"

export REPO_BRANCH=$(yq e '.concert.build.repository.branch' $CONFIG)
echo "Repository Branch: $REPO_BRANCH"

export COMMIT_SHA=$(yq e '.concert.build.repository.commit_sha' $CONFIG)
echo "Repository commit sha: $COMMIT_SHA"

export IMAGE_NAME=$(yq e '.concert.build.image.name' $CONFIG)
echo "Image Name: $IMAGE_NAME"

export IMAGE_TAG=$(yq e '.concert.build.image.tag' $CONFIG)
echo "Image Tag: $IMAGE_TAG"

export IMAGE_DIGEST=$(yq e '.concert.build.image.tag' $CONFIG)
echo "Image Tag: $IMAGE_DIGEST"

export CONCERT_URN_PREFIX=urn:ibm:appmgmt:${APP_NAME}

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"

  ###
  # upload build file
  ###

  envsubst < ${TEMPLATE_PATH}/template-build.json > ${DATA_OUT_PATH}/${OUT_FILE} 
