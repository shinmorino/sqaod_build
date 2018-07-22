#!/bin/bash

set -e

SQAODDIR=sqaod-${SQAODVER}

# To check changelog format.
# $ dpkg-source --before-build sqaod-${SQAODVER}

export SIMD_OPT=avx2
export CUDA_PREFIX=/usr/local/cuda-${CUDAVER}
export CFLAGS="-O2"

cd ${SQAODDIR}
./configure
make clean
cd ..
./build_deb.sh ${SQAODVER} avx2 ${CUDAVER}

mkdir -p packages
mv libsqaodc-avx2* packages

