#!/bin/bash

export SQAODVER=0.3.1
export CUDAVER=9.2

docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} shinmorino/sqaod_buildenv:artful bash -c 'cd /home/build_deb; ./build_sse2.sh; ./build_avx2.sh'

docker run -ti --rm -v `pwd`/build_deb:/home/build_deb shinmorino/sqaod_buildenv:artful bash -c 'cd /home/build_deb; ./build_py.sh py3'

mkdir -p packages
sudo rm -rf packages/artful
sudo mv build_deb/packages packages/artful

mkdir -p packages/pydist
cp build_deb/sqaod-${SQAODVER}/sqaodpy/dist/*.whl ./packages/pydist/
