#---------------------------------------------------------------------------------------------------------------------------
#----
#----   Start base image
#----
#---------------------------------------------------------------------------------------------------------------------------

FROM ros:humble-ros-core-jammy as base

## Parameters
ENV KOBUKI_ROOT=/kobuki

#############################################################################################################################
#####
#####   Install Dependencies
#####
#############################################################################################################################

WORKDIR /

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends  ros-dev-tools \
                                                ros-humble-angles \
                                                ros-humble-diagnostics \
                                                ros-humble-joint-state-publisher \
                                                ros-humble-ros-testing \
                                                ros-humble-action-msgs \
                                                udev

RUN apt-get clean

#############################################################################################################################
#####
#####   Install Kobuki packages
#####
#############################################################################################################################

WORKDIR ${KOBUKI_ROOT}/src

RUN git clone --recurse-submodules https://github.com/AIResearchLab/kobuki.git
RUN git clone --recurse-submodules https://github.com/AIResearchLab/kobuki_dependencies.git 

RUN rosdep init && rosdep update && rosdep install --from-paths ${KOBUKI_ROOT}/src -y --ignore-src


#############################################################################################################################
#####
#####   Build Kobuki packages
#####
#############################################################################################################################

WORKDIR ${KOBUKI_ROOT}

RUN . /opt/ros/humble/setup.sh && colcon build
WORKDIR /


#############################################################################################################################
#####
#####   Remove workspace source and build files that are not relevent to running the system
#####
#############################################################################################################################

RUN rm -rf ${KOBUKI_ROOT}/src
RUN rm -rf ${KOBUKI_ROOT}/log
RUN rm -rf ${KOBUKI_ROOT}/build
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*

RUN apt-get clean


#---------------------------------------------------------------------------------------------------------------------------
#----
#----   Start final release image
#----
#---------------------------------------------------------------------------------------------------------------------------


FROM ros:humble-ros-core-jammy as final

## Parameters
ENV KOBUKI_ROOT=/kobuki

WORKDIR /

COPY --from=base / /

RUN wget https://raw.githubusercontent.com/AIResearchLab/kobuki_ftdi/devel/60-kobuki.rules && \
    cp 60-kobuki.rules /etc/udev/rules.d && \
    service udev reload && \
    service udev restart

COPY workspace_entrypoint.sh /workspace_entrypoint.sh

RUN chmod +x /workspace_entrypoint.sh

ENTRYPOINT [ "/workspace_entrypoint.sh" ]

WORKDIR ${KOBUKI_ROOT}