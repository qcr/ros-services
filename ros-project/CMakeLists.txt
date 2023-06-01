cmake_minimum_required(VERSION 3.0.2)
project(ros_project)

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
  etc/ros-project.service
  DESTINATION /etc/systemd/system/
)
