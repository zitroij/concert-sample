#!/bin/bash
####

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

OUTPURDIR=${sourcecodedir}/concert_data
SRC_PATH=${sourcecodedir}/src

source ${VARIABLES_FILE}

#####
# source scanning stage
####

./helpers/code-scan-stage-gen-cyclondx-sbom.sh

#####
# build image stage
####

./build.sh

#####
# image scanning stage
####

#./helpers/image-scan-stage-gen-cyclondx-sbom.sh

#####
# gen concert build inventory
####

./helpers/gen-build-inventory.sh


#####
# send to concert stage
####
cp ../concert_data/simulating_ci_config.yaml ../concert_data/config.yaml
./helpers/concert_upload_data.sh
