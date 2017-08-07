FROM espressomd/buildenv-espresso-ubuntu:python
MAINTAINER Kai Szuttor <kai@icp.uni-stuttgart.de>

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV CUDA_VERSION 7.5.18
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

USER root

RUN apt-get update && apt-get install -y \
    wget \
    perl \
    module-init-tools \
    libbz2-ocaml-dev \
    g++-4.9 gcc-4.9 \
    curl

RUN cd /usr/bin  && rm gcc g++ && ln -s gcc-4.9 gcc && ln -s g++-4.9 g++

RUN wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    bash cuda_7.5.18_linux.run --toolkit --silent --override && \
    rm cuda_7.5.18_linux.run

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \     
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf 

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

RUN usermod -a -G www-data espresso
USER espresso
