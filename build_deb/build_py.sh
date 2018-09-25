#!/bin/bash

version=0.3.1

pyver=$1
sqaoddir=sqaod-${version}

dpkg -i packages/libsqaodc*.deb

rm -rf ${sqaoddir}/sqaodpy/dist/* ${sqaoddir}/sqaodpy/build/*
. /home/${pyver}/bin/activate
cd ${sqaoddir}/sqaodpy

python setup.py sdist bdist_wheel --plat-name manylinux1_x86_64

cd ../..

mkdir -p pydist
cp ${sqaoddir}/sqaodpy/dist/* pydist/
