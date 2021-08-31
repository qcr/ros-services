cmake_minimum_required(VERSION 3.0.2)
project(rv_panda_realsense_daemon)

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

configure_file(etc/panda-realsense.service.in panda-realsense.service)

install(FILES
  ${CMAKE_BINARY_DIR}/panda-realsense.service
  DESTINATION /etc/systemd/system/
)