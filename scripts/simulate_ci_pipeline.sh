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
echo "#### "

./concert-utils/helpers/code-scan-stage-gen-cyclondx-sbom.sh

echo "#####"
echo "# build image stage #"
echo "####"

./build.sh

echo "#####"
echo "# image scanning stage #"
echo "####"

#./concert-utils/helpers/image-scan-stage-gen-cyclondx-sbom.sh

echo "#####"
echo "# gen concert build inventory #"
echo "####"

./concert-utils/helpers/gen-build-inventory.sh


echo "#####"
echo "# send to concert stage #"
echo "####"

###
# upload build file
###
#echo "generating config file inventory json ${OUTPUTDIR}/${outfile_name} "

envsubst < ${OUTPUTDIR}/simulating_ci_config.yaml.template > ${OUTPUTDIR}/config.yaml

./concert-utils/helpers/concert_upload_data.sh
