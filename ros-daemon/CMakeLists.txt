cmake_minimum_required(VERSION 3.0.2)
project(ros_daemon)

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

configure_file(etc/ros.service.in ros.service)

install(DIRECTORY config/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/config
)

install(FILES
  ${CMAKE_BINARY_DIR}/ros.service
  DESTINATION /etc/systemd/system/
)
