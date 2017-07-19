FROM kaiszuttor/ubuntu1604_boost_1_61_0:latest
MAINTAINER Kai Szuttor <kai@icp.uni-stuttgart.de>

LABEL com.nvidia.volumes.needed="nvidia_driver"

USER root

RUN wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    bash cuda_7.5.18_linux.run --toolkit --silent --override && \
    rm cuda_7.5.18_linux.run

RUN wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run && \
    bash NVIDIA-Linux-x86_64-375.66.run --no-kernel-module --silent && \
    rm NVIDIA-Linux-x86_64-375.66.run

RUN usermod -a -G www-data espresso
USER espresso
