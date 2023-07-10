#!/bin/bash

#============================ VARIABLES ============================
IMAGE_TYPE="rpi"
ROOT_DIR=$(pwd)

#===================================================================





#============================= CONFIG ==============================

function help
{
   # Display Help
   echo "Script to automatically build yocto image for RPi 3B+ in Motur Project."
   echo
   echo "Syntax: ${0} [-h] [-t <type>]"
   echo "options:"
   echo "t     type of image buildt [rpi/qemu] (default=rpi)"
   echo "h     Print this Help."
   echo
}

while getopts ":ht" option; do
   case $option in
      h) # display Help
         help
         exit;;
      t) # choose type
         IMAGE_TYPE=${OPTARG}
         exit;;
   esac
done

#===================================================================




#check if IMAGE_TYPE is correct

git clone -b dunfell git://git.yoctoproject.org/poky.git poky-dunfell

cd poky-dunfell

git clone -b dunfell git://git.openembedded.org/meta-openembedded
git clone -b dunfell git://git.yoctoproject.org/meta-raspberrypi
# git clone -b dunfell git@github.com:ros/meta-ros build

cd ${ROOT_DIR}

source poky-dunfell/oe-init-build-env
echo "Current dir is:"
echo "\t" + $(pwd)
bitbake-layers add-layer ../poky-dunfell/meta-openembedded/meta-oe
bitbake-layers add-layer ../poky-dunfell/meta-openembedded/meta-python
bitbake-layers add-layer ../poky-dunfell/meta-openembedded/meta-networking
bitbake-layers add-layer ../poky-dunfell/meta-raspberrypi
# bitbake-layers add-layer ../poky-dunfell/meta-ros/ros-backports-gatesgarth-layer
# bitbake-layers add-layer ../poky-dunfell/meta-ros/ros-backports-hardknott-layer
# bitbake-layers add-layer ../poky-dunfell/meta-ros/meta-ros-common
# bitbake-layers add-layer ../poky-dunfell/meta-ros/meta-ros2
# bitbake-layers add-layer ../poky-dunfell/meta-ros/meta-ros2-galactic



sed -i 's/^MACHINE.*/MACHINE ??= "raspberrypi3-64"/' conf/local.conf

ADDITIONAL_PACKAGES="htop"
echo -e "\nIMAGE_INSTALL_append = \" ${ADDITIONAL_PACKAGES}\"\n" >> conf/local.conf

echo "#adding pi user and changing password for root" >> conf/local.conf
echo -e "EXTRA_USERS_PARAMS = \" useradd pi; usermod  -p \'raspberry\' pi; usermod  -a -G sudo pi; usermod -P root root;\"" >> conf/local.conf


