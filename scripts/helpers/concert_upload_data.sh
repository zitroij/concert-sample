#!/bin/bash

scriptdir=`dirname $0`

scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

OUTPURDIR=${sourcecodedir}/concert_data
SRC_PATH=${sourcecodedir}/src

source ${VARIABLES_FILE}

CODE_SCAN_COMMAND="upload-files.py"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPURDIR}:/toolkit-data localhost/ibm-concert-toolkit:v1 bash -c "${CODE_SCAN_COMMAND}"
