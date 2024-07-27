#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

export OUTPUTDIR=${sourcecodedir}/concert_data
export SRC_PATH=${sourcecodedir}/src

echo "#####"
echo "# source scanning stage #"
echo "# ./concert-utils/helpers/code-scan-stage-gen-cyclondx-sbom.sh --outputfile ${REPO_NAME}-cyclonedx-sbom-${BUILD_NUMBER}.json "
echo "#####"
./concert-utils/helpers/code-scan-stage-gen-cyclondx-sbom.sh --outputfile "${REPO_NAME}-cyclonedx-sbom-${BUILD_NUMBER}.json"

echo "#####"
echo "# build image stage #"
echo "#####"

./build.sh

export CYCLONEDX_FILENAME=${REPO_NAME}-cyclonedx-sbom-${BUILD_NUMBER}.json

echo "#####"
echo "# image scanning stage "
echo "# ./concert-utils/helpers/image-scan-stage-gen-cyclondx-sbom.sh --outputfile ${CYCLONEDX_FILENAME}"
echo "#####"
#./concert-utils/helpers/image-scan-stage-gen-cyclondx-sbom.sh --outputfile ${CYCLONEDX_FILENAME}


echo "#####"
echo "# gen concert build inventory (build sbom) "

export BUILD_FILENAME=${COMPONENT_NAME}-build-inventory-${BUILD_NUMBER}.json

CONCERT_DEF_CONFIG_FILE=build-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml

echo "envsubst < ${scriptdir}/${TEMPLATE_PATH}/build-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}"
envsubst < ${scriptdir}/${TEMPLATE_PATH}/build-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

echo "# ./concert-utils/helpers/gen-build-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}"
echo "#####"
./concert-utils/helpers/gen-build-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}

echo "#####"
echo "# send to concert stage #"
echo "#./concert-utils/helpers/concert_upload_data.sh"
echo "#####"
envsubst < ${scriptdir}/${TEMPLATE_PATH}/simulating_ci_config.yaml.template > ${OUTPUTDIR}/config.yaml
./concert-utils/helpers/concert_upload_data.sh
