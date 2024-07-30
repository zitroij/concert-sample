#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

export OUTPUTDIR=${sourcecodedir}/concert_data

###
# application toolkit config yaml
###
export APP_FILE_NAME="${APP_NAME}-${APP_VERSION}-application.json"

CONCERT_DEF_CONFIG_FILE=app-${APP_NAME}-${APP_VERSION}-config.yaml
envsubst < ${scriptdir}/${TEMPLATE_PATH}/app-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

echo "#####"
echo "# gen concert app inventory"
echo "# ./concert-utils/helpers/create-application-sbom.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}"
echo "####"

./concert-utils/helpers/create-application-sbom.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}

echo "#####"
echo "# send to concert stage"
echo "#####"

envsubst < ${scriptdir}/${TEMPLATE_PATH}/application_def_load_config.yaml.template > ${OUTPUTDIR}/config.yaml
./concert-utils/helpers/concert_upload.sh --outputdir ${OUTPUTDIR}
