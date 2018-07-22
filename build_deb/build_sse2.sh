#!/bin/bash

set -e

SQAODDIR=sqaod-${SQAODVER}

# To check changelog format.
# $ dpkg-source --before-build sqaod-${SQAODVER}

export SIMD_OPT=
export CUDA_PREFIX=/usr/local/cuda-${CUDAVER}
export CFLAGS="-O2"

cd ${SQAODDIR}
./configure
make clean
cd ../
./build_deb.sh ${SQAODVER} sse2 ${CUDAVER}

mkdir -p packages

mv  *.deb *.changes *.dsc *.tar.xz *.tar.gz packages 2> /dev/null
if ls *.buildinfo > /dev/null 2>&1
then
    mv *.buildinfo packages/
fi
if ls *.ddeb > /dev/null 2>&1
then
    mv *.ddeb packages/
fi
