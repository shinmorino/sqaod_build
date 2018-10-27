#!/bin/bash

SQAODVER=${1}
SIMD_OPT=${2}
CUDAVER=${3}
SQAODDIR=sqaod-${SQAODVER}

. /etc/lsb-release


tar -czf debian.tgz ${SQAODDIR}/debian
cd ${SQAODDIR}

export CFLAGS="-O2"

cd debian
cat changelog.tmpl | sed s/@DIST@/${DISTRIB_CODENAME}/g > changelog
python gen.py ${SQAODVER} ${DISTRIB_CODENAME} ${SIMD_OPT} ${CUDAVER} 
cd ..

pushd .
cd ..
tar -czf sqaod_${SQAODVER}.orig.tar.gz ${SQAODDIR}
popd
DEB_BUILD_OPTIONS='parallel=4 nocheck' dpkg-buildpackage -us -uc

cd ..

# clean temporary files.
rm -rf ${SQAODDIR}/debian
tar -xzf debian.tgz
rm -f debian.tgz

