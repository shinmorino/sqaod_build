#!/bin/bash

version=$1
simd=$2
cudaver=$3

cd sqaod-${version}
make distclean > /dev/null 2>&1

set -e

echo autogen
./autogen.sh > test_build.log 2>&1
export CUDA_PREFIX=/usr/local/cuda-${cudaver}
export SIMD_OPT=${simd}
echo configure
./configure --enable-cuda >> test_build.log 2>&1

echo 'build lib'
make -j8 >> test_build.log 2>&1
echo 'build test'
make -C sqaodc/tests -j8 test >> test_build.log 2>&1

echo 'run test'
./sqaodc/tests/test 2>&1 | tee -a test_build.log
