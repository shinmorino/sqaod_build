#!/bin/bash

version=`cat VERSION`
dist=${1:-xenial}
simd=${2:-sse2}
cudaver=${3:-9.0}

container_name=sqaod-test-${dist}-${simd}-${cudaver}
docker rm ${container_name} > /dev/null 2>&1

docker run --runtime=nvidia -ti -v`pwd`/tests:/home/tests -e SIMD=${simd} -e CUDAVER=${cudaver} -e SQAODVER=${version} --name ${container_name}  shinmorino/sqaod_buildenv:${dist} bash -c 'cd /home/tests; ./test_lib.sh $SQAODVER $SIMD $CUDAVER'

#export CUDAVER=9.2
#docker run -ti --rm -v`pwd`/build_deb:/home/build_deb -e CUDAVER=${CUDAVER} -e SQAODVER=${SQAODVER}# shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_cuda.sh;'

#docker run -ti --rm -v `pwd`/build_deb:/home/build_deb shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_py.sh py2; ./build_py.sh py3'
