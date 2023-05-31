cmake_minimum_required(VERSION 3.0.2)
project(ros_robot)

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

install(FILES
  etc/ros-robot.service
  DESTINATION /etc/systemd/system/
)
