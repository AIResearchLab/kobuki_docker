#!/bin/bash
set -e

# reload udev
service udev reload
service udev restart
    
# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "$KOBUKI_ROOT/install/setup.bash"


exec "$@"
