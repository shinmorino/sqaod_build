#!/bin/bash

SQAODVER=`cat VERSION`

export CUDAVER=9.0
docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_sse2.sh; ./build_avx2.sh'

#export CUDAVER=9.2
#docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_cuda.sh;'

export CUDAVER=10.0
docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_cuda.sh;'

mkdir -p packages
sudo rm -rf packages/xenial
sudo mv build_deb/packages packages/xenial
