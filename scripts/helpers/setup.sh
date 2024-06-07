################
# Get the toolkit image, use the toolkit image commands from the sript to generate the content.
# Temporarily building this locally while we publish the image and do a docker pull.
# assumption - user has access git cli, docker running on the environment.  Git is configure with ssh kays to access ghe
#  
################

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/../..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

echo -e "export DATA_OUT_PATH=${sourcecodedir}/concert_data"   >> ${VARIABLES_FILE}

docker pull stg.icr.io/cp/roja/ibm-concert-toolkit:v1-dev

