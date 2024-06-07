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

./helper/code-scan-stage-gen-cyclondx-sbom.sh

#####
# build image stage
####

./build.sh

#####
# gen concert app inventory
####

./helper/gen-build-inventory.sh

#####
# image scanning stage
####

#./helper/image-scan-stage-gen-cyclondx-sbom.sh


#####
# send to concert stage
####

# work inprogress


