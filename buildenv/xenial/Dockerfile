FROM ubuntu:16.04
MAINTAINER Shinya Morino <shin.morino@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# register CUDA repo
RUN echo  'deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /' > /etc/apt/sources.list.d/cuda.list
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

# prepare apt-get
RUN apt-get update
RUN apt-get -y install apt-utils

# install CUDA
RUN apt-get install --no-install-recommends -y cuda-core-9-0 cuda-command-line-tools-9-0 cuda-libraries-9-0 cuda-libraries-dev-9-0
#RUN apt-get install --no-install-recommends -y cuda-core-9-1 cuda-compiler-9-1 cuda-command-line-tools-9-1 cuda-libraries-9-1 cuda-libraries-dev-9-1
RUN apt-get install --no-install-recommends -y cuda-core-9-2 cuda-compiler-9-2 cuda-command-line-tools-9-2 cuda-libraries-9-2 cuda-libraries-dev-9-2
RUN apt-get install --no-install-recommends -y cuda-core-10-0 cuda-compiler-10-0 cuda-command-line-tools-10-0 cuda-libraries-10-0 cuda-libraries-dev-10-0

# install python env
RUN apt-get install -y python-dev python3.5-dev
RUN apt-get install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# creating py2/py3 virtualenv
RUN python get-pip.py
RUN pip install virtualenv
RUN cd /home
RUN virtualenv -p /usr/bin/python /home/py2
RUN virtualenv -p /usr/bin/python3.5 /home/py35
RUN . /home/py2/bin/activate; pip install numpy==1.11
RUN . /home/py35/bin/activate; pip install numpy==1.11

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
