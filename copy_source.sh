#!/bin/bash

version=`cat VERSION`
sudo chown -R `id -u`:`id -g` .

rm -rf sqaod-${version}
cp -r sqaod sqaod-${version}
find sqaod-${version} | grep '\.git$' | xargs rm -rf 

# deb
rm -rf build_deb/sqaod-${version}
cp -r sqaod-${version} build_deb/

# rpm
rm -rf rpm/build/SOURCES/*
tar -czf rpmbuild/SOURCES/sqaod-${version}.tar.gz sqaod-${version}

# tests
rm -rf tests/sqaod-${version}
cp -r sqaod-${version} tests/
