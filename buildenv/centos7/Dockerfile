FROM centos:7.5.1804
MAINTAINER Shinya Morino <shin.morino@gmail.com>

# register CUDA repo
COPY cuda.repo /etc/yum.repos.d/cuda.repo

# prepare apt-get
RUN yum clean all
RUN yum install -y cuda-core-9-0 cuda-command-line-tools-9-0 cuda-libraries-9-0 cuda-libraries-dev-9-0
RUN yum install -y cuda-compiler-9-2 cuda-command-line-tools-9-2 cuda-libraries-9-2 cuda-libraries-dev-9-2

# install python env
RUN yum install -y python-devel
RUN yum install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# creating py2 virtualenv
RUN python get-pip.py
RUN pip install virtualenv
RUN cd /home
RUN virtualenv -p /usr/bin/python /home/py2
RUN . /home/py2/bin/activate; pip install numpy==1.11

# install buildtools
RUN yum install -y automake autoconf libtool make
RUN yum install -y rpm-build
RUN yum clean all

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.0"
