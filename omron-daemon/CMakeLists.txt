cmake_minimum_required(VERSION 3.0.2)
project(ros_omron_agv_daemon)

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

configure_file(etc/omron-driver.service.in omron-driver.service)

install(FILES
  ${CMAKE_BINARY_DIR}/omron-driver.service
  DESTINATION /etc/systemd/system/
)