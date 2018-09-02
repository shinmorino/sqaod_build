#!/bin/bash

SQAODVER=`cat VERSION`
export SQAODVER

export CUDAVER=9.0
export simd=sse2
docker run --runtime=nvidia -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER} -e simd=${simd} shinmorino/sqaod_buildenv:artful bash -c 'cd /home/build_deb; ./build_${simd}.sh; bash'
