#!/bin/bash

TEMPLATE=@(InstallationPrefix)/share/ros_env/config/ros-env.conf
CUSTOM=/etc/ros-env.conf

if [ -e "$CUSTOM" ]; then
  if [ "$(md5sum $TEMPLATE | awk '{print $1}')" != "$(md5sum $CUSTOM | awk '{print $1}')" ]; then
    while true; do
      read -p "Local ros-env configuration exists. Replace [y/N]? " yn
      case $yn in
        [Yy]* ) echo 'Copying ros-env configuration'; cp $TEMPLATE $CUSTOM; break;;
        [Nn]* ) break;;
      esac
    done
  fi
else
  echo 'Copying ros-env configuration'
  cp $TEMPLATE $CUSTOM;
fi
