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

cp demo_build_envs.variables.template ${VARIABLES_FILE}

if [ -d "tmp" ]
then
 echo "recreating  temp directory"
 rm -rf tmp
fi

mkdir tmp
cd tmp
git clone --branch jio/envsubst-update git@github.ibm.com:roja/toolkit.git

toolkit/build.sh

rm -rf tmp

REPO_COMMIT_SHA="$(git rev-parse HEAD)"
REPO_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo -e "export REPO_BRANCH=${REPO_BRANCH}"  >> ${VARIABLES_FILE}
echo -e "export REPO_COMMIT_SHA=${REPO_COMMIT_SHA}"  >> ${VARIABLES_FILE}