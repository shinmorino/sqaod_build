#!/bin/bash

sudo rm -rf build_deb/packages
sudo cp -r packages/xenial build_deb/packages

docker run -ti --rm -v `pwd`/build_deb:/home/build_deb shinmorino/sqaod_buildenv:xenial bash -c 'cd /home/build_deb; ./build_py.sh py2; ./build_py.sh py35'

sudo rm -rf build_deb/packages

mkdir -p packages/pydist
cp build_deb/pydist/* ./packages/pydist/
