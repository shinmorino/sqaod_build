#!/bin/bash

version=`cat VERSION`
dist=${1:-xenial}

docker run -e NVIDIA_VISIBLE_DEVICES=1 --rm -ti -v`pwd`/tests:/home/tests shinmorino/sqaod_buildenv:${dist} bash -c 'cd /home/tests; ./test_install.sh; bash'
