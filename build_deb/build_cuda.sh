#!/bin/bash

set -e

SQAODDIR=sqaod-${SQAODVER}

# To check changelog format.
# $ dpkg-source --before-build sqaod-${SQAODVER}

export SIMD_OPT=sse2
export CUDA_PREFIX=/usr/local/cuda-${CUDAVER}
export CFLAGS="-O2"

ls
echo SQDIR ${SQAODDIR}
cd ${SQAODDIR}
./configure
make clean
cd ..
./build_deb.sh ${SQAODVER} sse2 ${CUDAVER}

mkdir -p packages
mv libsqaodc-cuda* packages
