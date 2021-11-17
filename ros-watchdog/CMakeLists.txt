cmake_minimum_required(VERSION 3.0.2)
project(ros_watchdog)

find_package(catkin REQUIRED)

###################################
## catkin specific configuration ##
###################################

catkin_package(
)

###########
## Build ##
###########

include_directories(
)

#############
## Install ##
#############

catkin_install_python(PROGRAMS
  scripts/ros-watchdog
  DESTINATION /usr/bin
)

install(FILES
  etc/ros-watchdog.service
  DESTINATION /etc/systemd/system/
)