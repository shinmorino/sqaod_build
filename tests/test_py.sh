#!/bin/bash

run()
{
    pyver=$1
    simd=$2
    cudaver=$3
    
    ${alternatives} --set libsqaodc.so.1 ${libdir}/libsqaodc-${simd}/libsqaodc.so.1
    ${alternatives} --set libsqaodc_cuda.so.1 ${libdir}/libsqaodc-cuda-${cudaver}/libsqaodc_cuda.so.1
    ${alternatives} --query libsqaodc.so.1 | grep Value | grep $simd
    ${alternatives} --query libsqaodc_cuda.so.1 | grep Value | grep $cudaver
    
    . /home/${pyver}/bin/activate
    cpyver=`python -c "import sys; info = sys.version_info; print('cp' + str(info[0]) + str(info[1]))"`
    pip install pydist/sqaod-${version}-${cpyver}-*.whl
    
    rm -rf pytests
    cp -r sqaod-${version}/sqaodpy/tests pytests
    python -m unittest pytests

}


version=${1:-1.0.0}
pyver=${2:-py2}
simd=${3:-sse2}


if test -f /etc/lsb-release
then
    # ubuntu
    dpkg -i packages/*.deb
    export alternatives=/usr/bin/update-alternatives
    export libdir=/usr/lib
fi

if test -f /etc/redhat-release
then
    rpm -Uvh packages/*.rpm
    export alternatives=/sbin/alternatives
    export libdir=/usr/lib64
fi


for pyver in ${PYVERS}
do
    for cudaver in ${CUDAVERS}
    do
	cudaver=`echo $cudaver | tr . -`
	run $pyver sse2 $cudaver
	run $pyver avx2 $cudaver
    done
done
