#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

export APP_FILE_NAME="${APP_NAME}-${APP_VERSION}-application.json"

echo "#####"
echo "# gen concert app inventory"
echo "# ./concert-utils/helpers/gen-concert-application.sh --outfile ${APP_FILE_NAME}"
echo "####"

./concert-utils/helpers/gen-concert-application.sh --outfile ${APP_FILE_NAME}

echo "#####"
echo "# send to concert stage"
echo "#####"

envsubst < ${OUTPUTDIR}/application_def_load_config.yaml.template > ${OUTPUTDIR}/config.yaml
./concert-utils/helpers/concert_upload_data.sh
