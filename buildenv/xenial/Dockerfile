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
RUN apt-get install -y cuda-core-9-0 cuda-command-line-tools-9-0 cuda-libraries-9-0 cuda-libraries-dev-9-0
#RUN apt-get install -y cuda-core-9-1 cuda-compiler-9-1 cuda-command-line-tools-9-1 cuda-libraries-9-1 cuda-libraries-dev-9-1
RUN apt-get install -y cuda-core-9-2 cuda-compiler-9-2 cuda-command-line-tools-9-2 cuda-libraries-9-2 cuda-libraries-dev-9-2

# install python env
RUN apt-get install -y python-dev python3-dev
RUN apt-get install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# creating py2/py3 virtualenv
RUN python get-pip.py
RUN pip install virtualenv
RUN cd /home
RUN virtualenv -p /usr/bin/python /home/py2
RUN virtualenv -p /usr/bin/python /home/py3
RUN . /home/py2/bin/activate; pip install numpy==1.11
RUN . /home/py3/bin/activate; pip install numpy==1.11

# install buildtools
RUN apt-get install -y automake autoconf libtool
RUN apt-get install -y debhelper autotools-dev
RUN apt-get install -y git
RUN apt-get autoclean
