cmake_minimum_required(VERSION 3.0.2)
project(rv_panda_daemon)

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

configure_file(etc/panda-driver.service.in panda-driver.service)

install(FILES
  ${CMAKE_BINARY_DIR}/panda-driver.service
  DESTINATION /etc/systemd/system/
)