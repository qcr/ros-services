cmake_minimum_required(VERSION 3.0.2)
project(ros_env)

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

install(DIRECTORY config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
