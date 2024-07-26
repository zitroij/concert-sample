#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

#####
# gen concert app inventory
####
export APP_FILE_NAME="${APP_NAME}-${APP_VERSION}-application.json"

./concert-utils/helpers/gen-concert-application.sh --outfile ${APP_FILE_NAME}

cd ${scriptdir}

#####
# send to concert stage
####
###
# upload build file
###
#echo "generating config file inventory json ${OUTPUTDIR}/${outfile_name} "

envsubst < ${OUTPUTDIR}/application_def_load_config.yaml.template > ${OUTPUTDIR}/config.yaml
./concert-utils/helpers/concert_upload_data.sh
