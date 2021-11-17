cmake_minimum_required(VERSION 3.0.2)
project(qcr_env)

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

configure_file(
  etc/qcr-env.bash.in qcr-env.bash
  @ONLY
)

install(FILES
  ${PROJECT_BINARY_DIR}/qcr-env.bash
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/etc/
)