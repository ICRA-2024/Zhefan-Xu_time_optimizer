FROM osrf/ros:noetic-desktop-full

# Set up the environment
ENV DEBIAN_FRONTEND=noninteractive
ENV CATKIN_WS=/root/catkin_ws

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    build-essential \
    python3-catkin-tools \
    && rm -rf /var/lib/apt/lists/*
    
# Create and initialize the Catkin workspace
RUN mkdir -p $CATKIN_WS/src

# Clone the repository and its dependencies
WORKDIR $CATKIN_WS/src
RUN git clone https://github.com/ICRA-2024/Zhefan-Xu_time_optimizer.git \
    && git clone https://github.com/Zhefan-Xu/global_planner.git \
    && git clone https://github.com/Zhefan-Xu/trajectory_planner.git \
    && git clone https://github.com/Zhefan-Xu/map_manager.git

# Build the workspace
WORKDIR $CATKIN_WS
RUN catkin_make

# Set up the environment for ROS
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo "source $CATKIN_WS/devel/setup.bash" >> ~/.bashrc

# Set the default command to launch a bash shell
CMD ["bash"]
