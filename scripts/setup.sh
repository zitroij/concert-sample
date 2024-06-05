################
# Get the toolkit image, use the toolkit image commands from the sript to generate the content.
# Temporarily building this locally while we publish the image and do a docker pull.
# assumption - user has access git cli, docker running on the environment.  Git is configure with ssh kays to access ghe
#  
################

echo `pwd`

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