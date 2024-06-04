################
# Get the toolkit image, use the toolkit image commands from the sript to generate the content.
# Temporarily building this locally while we publish the image and do a docker pull.
# assumption - user has access git cli, docker running on the environment.  Git is configure with ssh kays to access ghe
#  
################

mkdir tmp

cd tmp

git clone git@github.ibm.com:roja/toolkit.git

toolkit/build.sh
