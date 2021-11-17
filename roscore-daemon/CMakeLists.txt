cmake_minimum_required(VERSION 3.0.2)
project(roscore_daemon)

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
  etc/roscore.service
  DESTINATION /etc/systemd/system/
)