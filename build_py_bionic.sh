#!/bin/bash
version=`cat VERSION`

sudo rm -rf build_deb/packages
sudo cp -r packages/bionic build_deb/packages

docker run -ti --rm -v `pwd`/build_deb:/home/build_deb -e SQAODVER=${version} shinmorino/sqaod_buildenv:bionic bash -c 'cd /home/build_deb;./build_py.sh py36; ./build_py.sh py37'

sudo rm -rf build_deb/packages

mkdir -p packages/pydist
cp build_deb/pydist/* ./packages/pydist/
