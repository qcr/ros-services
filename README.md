# QCR ROS Services <!-- omit in toc -->

The QCR ROS Services provides an easily extendable framework to allow certain elements of the ROS ecosystem to run on boot using the [systemd software suite](https://en.wikipedia.org/wiki/Systemd). This is useful for robots that are required to provide a fixed set of functionality at all times regardless of use-case (e.g., starting up base drivers).

- [QCR-Env](#qcr-env)
- [QCR-Services](#qcr-services)
  - [Service Dependency Tree](#service-dependency-tree)
- [Installation](#installation)
  - [Step 1. Adding QCR Apt Repositories](#step-1-adding-qcr-apt-repositories)
  - [Step 2. Installing the Packages](#step-2-installing-the-packages)
- [Usage](#usage)
  - [Creating and Configuring Services](#creating-and-configuring-services)
  - [Starting/Stopping the Services](#startingstopping-the-services)
  - [Accessing Logs](#accessing-logs)
- [Usage on a Development Machine](#usage-on-a-development-machine)

## QCR Env

The qcr-env package installs the ```qcr-env.bash``` file to ```/etc/qcr/```. This file defines system critical information such as the location of the primary ROS workspace, and ROS master location. These variables are utilised by the various services below. For example, the roscore-daemon relies on having the ROS workspace sourced in order to start a roscore.

*Note*: This file can be optionally sourced within your ```~/.bashrc``` to provide access to robot state information.

*Install*: `sudo apt install ros-noetic-qcr-env` (requires GPG Key to be set, see [below](#installation))

### ROS Primary & Peripheral

The QCR Environment bash script makes configuring ROS Primary (Master) / Periperhal (Slave) systems easy. First, ensure both devices are on the same network.

To configure a machine as the primary:
1. Open `/etc/qcr/qcr-env.bash` in an editor.
2. Ensure `QCR_IS_PRIMARY` is set to true (i.e., `QCR_IS_PRIMARY=true`).
3. Set `QCR_ROS_IP_PRIMARY` to the Primary's IP address.

To configure a peripheral machine:
1. Open `/etc/qcr/qcr-env.bash` in an editor.
2. Ensure `QCR_IS_PRIMARY` is set to false (i.e., `QCR_IS_PRIMARY=false`).
3. Set `QCR_ROS_IP_PRIMARY` to the Primary's IP address.
4. Set `QCR_ROS_IP_PERIPHERAL` to the Peripheral's IP address.
5. Restart the ROS service by running `sudo systemctl restart ros.service`

## QCR Services

The QCR Services package installs 6 systemd services. These are the:

- **ROS Service**: a meta-service that when started brings up the rest of the services provided by this repository, and conversely, when stopped will shutdown these same services (see the dependency tree below). It should be noted that this service does not execute any ROS software itself.
- **ROS-Core Service**: this service creates a ROS master by executing the ```roscore``` command on startup; using the system variables defined in ```/etc/qcr/qcr-env.bash```.
- **ROS-Watchdog Service**: this service is responsible for ensuring that the ROS master specified in ```/etc/qcr/qcr-env.bash``` is alive and managing the life-cycle of its dependent services accordingly. In the event that it is unable to contact the ROS master it initiates a restart - causing all dependent services to stop. Until the ROS master is contactable, the ros-watchdog service will remain in an *activating* state, preventing its dependent services from restarting. Once the ROS master becomes contactable again however, the ros-watchdog will transition into an *activated* state, and its dependent services will restart. This service can be located on a different machine to the ROS master, facilitating multi-machine management of services.
- **ROS-Sensors Service**: a meta-service that when started brings up any dependent services, and conversely, when stopped will shutdown these same services. This meta-service is meant to be used as the dependent service for all sensors that should be launched on boot.
- **ROS-Robot Service**: a meta-service that when started brings up any dependent services, and conversely, when stopped will shutdown these same services. This meta-service is meant to be used as the dependent service for all components that should be launched on boot required by the robot (e.g., teleoperation node, hardware interface nodes, etc.).
- **ROS-Project Service**: is a meta-service that when started brings up any dependent services, and conversely, when stopped will shutdown these same services. This meta-service is meant to be used as the dependent service for all components that should be launched on boot for your specific project (e.g., nodes containing research algorithms).

*Install*: `sudo apt install ros-noetic-qcr-services` (requires GPG Key to be set, see [below](#installation)). Depends on the qcr-env package and hence, the qcr-env package will be installed if it isn't already.

### Service Dependency Tree

To allow for multi-machine configurations, and to provide a simplified mechanism for shutting down the complete set of services, we define a dependency tree, (seen in the image below) that facilitates the ability to manage the robot state at varying levels. For instance, by stopping the *ros* service on Machine 1 using the command ```sudo service ros stop``` the *ros-watchdog* and *roscore* services, which depend on the *ros* service will stop which will in turn cause all depedent services to stop.

![Service Dependency Tree](services.png)

Note that the *ros-watchdog* service has a soft dependency on the *roscore* service (indicated by the dashed line). When the *ros-watchdog* service is started, it will enter an initial *starting* state, which prevents any of its dependent services from starting. When it detects the ROS master has started, which it does by polling the ROS master at a frequency of 1hz, it will enter a *started* state, allowing its dependent services to start. In the event that the ROS master does not respond (due to being stopped), the ros-watchdog will go through a restart procedure, which will cause its dependent services to stop, before entering back into its *starting* state and waiting for the ROS Master to come back online.

This design allows us to create services that depend on a ROS Master that may be running on a different machine, a capability that is not provided by regular systemd dependencies.

## Installation

Installation of these packages is intended to be done through the APT package manager.

### Step 1. Adding QCR Apt Repositories
Import the GPG Key using the following command

```sh
sudo -E apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-key 5B76C9B0
```

Add the Robotic Vision repository to the apt sources list directory

```sh
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] https://packages.qcr.ai $(lsb_release -sc) main" > /etc/apt/sources.list.d/qcr-latest.list'
```

Update your packages list

```sh
sudo apt update
```

### Step 2. Installing the Packages

Install the qcr-env package via:
```
sudo apt install ros-noetic-qcr-env
```

Install the qcr-services package via:
```
sudo apt install ros-noetic-qcr-services
```

*Note*: As part of the installation process, the services will automatically startup and register themselves to start on boot.

## Usage

## Creating and Configuring Services
To create and configure services we recommend you utilise the [QCR Services Configuration Tool](https://github.com/qcr/services).

### Starting/Stopping the Services
Managing the state of the services in this package can be accomplished through the use of either the ```service``` or ```systemctl``` commands:

```sh
sudo service {{service name}} [start|stop|restart|status]
#OR
sudo systemctl [start|stop|restart|status] {{service name}}
```

Where ```{{service name}}``` is the name of the service you wish to manage (i.e., ros, roscore, ros-watchdog, robot-bringup).

### Accessing Logs
Accessing stdout logs from each of the services can be accomplished using the ```journalctl``` command:

```sh
journalctl -u {{service name}} --follow --lines 500
```

Where ```{{service name}}``` is the name of the service you wish to manage (i.e., ros, roscore, ros-watchdog, robot-bringup).


## Usage on a Development Machine
The ```/etc/qcr/qcr-env.bash``` file installed by the qcr-env package is copied from a template file that is located in the system install lcation for ROS (e.g., /opt/ros/noetic/share/qcr_env/). This file is only copied if ```/etc/qcr/qcr-env.bash``` does not already exists.

This allows local changes to be preserved when the package is upgraded, and additionally, allows local changes to be tracked after installation using the [QCR robot_system_config tools](https://github.com/qcr/robot_system_configs).

