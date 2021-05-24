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

configure_file(etc/roscore.service.in roscore.service)

install(FILES
  ${CMAKE_BINARY_DIR}/roscore.service
  DESTINATION /etc/systemd/system/
)