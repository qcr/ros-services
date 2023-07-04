cmake_minimum_required(VERSION 3.0.2)
project(qcr_services)

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
  etc/ros.service
  etc/ros-watchdog.service
  etc/roscore.service
  etc/ros-sensors.service
  etc/ros-robot.service
  etc/ros-project.service
  DESTINATION /etc/systemd/system/
)