#!/bin/bash

apt-get update
apt-get install -y apt-transport-https apt-utils

. /etc/lsb-release

cat /home/tests/sqaod.list | sed s/@DIST@/${DISTRIB_CODENAME}/g | tee /etc/apt/sources.list.d/sqaod.list

curl -s -L https://shinmorino.github.io/sqaod/gpgkey | apt-key add -

apt-get update
