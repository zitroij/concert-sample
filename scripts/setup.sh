#!/bin/bash
################
# Get the toolkit image, use the toolkit image commands from the sript to generate the content.
# Temporarily building this locally while we publish the image and do a docker pull.
# assumption - user has access git cli, docker running on the environment.  Git is configure with ssh kays to access ghe
#  
################

scriptdir=`dirname $0`

scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables
source ${VARIABLES_FILE}

git clone ${CONCERT_TOOLKIT_UTILS_REPO}

if which docker >/dev/null; then
    dockerexe = docker 
elifwhich podman >/dev/null; then
    dockerexe podman
else
    echo "docker or podman are not installed need a container runtime environment"
    exit -1
fi
${dockerexe} pull ${CONCERT_TOOLKIT_IMAGE}




