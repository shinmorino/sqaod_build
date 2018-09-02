FROM ubuntu:17.10
MAINTAINER Shinya Morino <shin.morino@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# prepare apt-get
RUN apt-get update
RUN apt-get -y install apt-utils dirmngr

# register CUDA repo
RUN echo  'deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64 /' > /etc/apt/sources.list.d/cuda.list
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64/7fa2af80.pub

# install CUDA
RUN apt-get update
RUN apt-get install -y cuda-compiler-9-2 cuda-command-line-tools-9-2 cuda-libraries-9-2 cuda-libraries-dev-9-2

# install python env
RUN apt-get install -y python-dev python3.6-dev python3.7-dev
RUN apt-get install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# creating py2/py3 virtualenv
RUN python get-pip.py
RUN pip install virtualenv
RUN cd /home
RUN virtualenv -p /usr/bin/python /home/py2
RUN virtualenv -p /usr/bin/python3.6 /home/py36
RUN virtualenv -p /usr/bin/python3.7 /home/py37
RUN ln -sf locale.h /usr/include/xlocale.h # workaround on glibc header change.
RUN . /home/py2/bin/activate; pip install numpy==1.11
RUN . /home/py36/bin/activate; pip install numpy==1.11
RUN . /home/py37/bin/activate; pip install numpy==1.11

# install buildtools
RUN apt-get install -y automake autoconf libtool
RUN apt-get install -y debhelper autotools-dev
RUN apt-get install -y git
RUN apt-get autoclean

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.0"
