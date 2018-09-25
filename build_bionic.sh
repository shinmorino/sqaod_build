#!/bin/bash

SQAODVER=`cat VERSION`
export CUDAVER=10.0

docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:bionic bash -c 'cd /home/build_deb; ./build_sse2.sh; ./build_avx2.sh'

mkdir -p packages
sudo rm -rf packages/bionic
sudo mv build_deb/packages packages/bionic
