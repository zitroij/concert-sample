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
# gen concert app inventory
####
./helpers/gen-concert-application.sh

cd ${scriptdir}
#####
# gen concert app inventory
####
#####
# send to concert stage
####
cp ../concert_data/application_def_load_config.yaml ../concert_data/config.yaml
./helpers/concert_upload_data.sh
