#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

export OUTPUTDIR=${sourcecodedir}/concert_data

echo "#####"
echo "# gen concert deploy inventory #"
echo "####"
export DEPLOY_FILENAME="${COMPONENT_NAME}-deploy-inventory-${BUILD_NUMBER}.json"

CONCERT_DEF_CONFIG_FILE=deploy-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml
envsubst < ${scriptdir}/${TEMPLATE_PATH}/deploy-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

echo "generating deploy sbom"
echo "./concert-utils/helpers/gen-deploy-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}" 
./concert-utils/helpers/gen-deploy-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}

###
# upload build file
###
#echo "generating config file inventory json ${OUTPUTDIR}/${outfile_name} "
envsubst < ${scriptdir}/${TEMPLATE_PATH}/simulating_cd_config.yaml.template > ${OUTPUTDIR}/config.yaml
./concert-utils/helpers/concert_upload_data.sh --outputdir ${OUTPUTDIR}
