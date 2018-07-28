#!/bin/bash

version=`cat VERSION`

if test -d sqaod
then
    mv sqaod sqaod-${version}
fi

# deb
rm -rf build_deb/sqaod-${version}
cp -r sqaod-${version} build_deb/

# rpm
rm -rf rpm/build/SOURCES/*
tar -czf rpmbuild/SOURCES/sqaod-${version}.tar.gz sqaod-${version}
