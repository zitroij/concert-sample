#!/bin/bash


. ../concert_data/demo_release_envs.variables

RELEASE_FILENAME=../concert-data/release-config.yaml

cat > ${RELEASE_FILENAME} << EOD
concert:
    release:
      app_name: ${APP_NAME}
      number: ${BUILD_NUMBER}
      version: ${APP_VERSION}
EOD
