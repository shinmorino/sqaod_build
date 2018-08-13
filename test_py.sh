#!/bin/bash

version=`cat VERSION`
dist=${1:-xenial}
. conf/$dist

rm -rf tests/packages
rm -rf tests/pydist
cp -r packages/${dist} tests/packages
cp -r packages/pydist tests/

docker run --rm -ti -v`pwd`/tests:/home/tests -e SIMD=${simd} -e SQAODVER=${version} -e PYVERS="${pyvers}" -e CUDAVERS="${cudavers}" shinmorino/sqaod_buildenv:${dist} bash -c 'cd /home/tests; ./test_py.sh $SQAODVER; bash'
