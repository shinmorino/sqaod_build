#!/bin/bash

SQAODVER=`cat VERSION`
sudo chown root:root -R rpmbuild
docker run -ti --rm -v`pwd`/rpmbuild:/root/rpmbuild shinmorino/sqaod_buildenv:centos7 bash -c 'cd /root/rpmbuild/SPECS; ./gen_spec.sh; rpmbuild -ba libsqaodc-sse2-cuda-10-0-devel.spec; rpmbuild -ba libsqaodc-avx2.spec; '

mkdir -p packages
sudo rm -rf packages/centos7
sudo mv rpmbuild/RPMS/* packages/centos7
sudo mv rpmbuild/SRPMS/* packages/centos7
