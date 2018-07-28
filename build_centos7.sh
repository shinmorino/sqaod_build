#!/bin/bash

export SQAODVER=0.3.1

export CUDAVER=9.0
docker run -ti --rm -v`pwd`/rpmbuild:/root/rpmbuild -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:centos7 bash #-c 'cd /root; ./build_sse2.sh; ./build_avx2.sh'

#export CUDAVER=9.2
#docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER}# shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_cuda.sh;'
