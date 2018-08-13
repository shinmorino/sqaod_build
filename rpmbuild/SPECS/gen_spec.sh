#!/bin/bash

generate()
{
    build_vpkg=$1
    build_simd=$2
    simd=$3
    simd_priority=$4
    build_cuda=$5
    cudaver=$6
    cuda_priority=$7
    build_devel=$8
    cat libsqaodc.tmpl.spec | sed "s/@BUILD_VPKG@/$build_vpkg/g; s/@BUILD_SIMD@/$build_simd/g; s/@BUILD_CUDA@/$build_cuda/g; s/@BUILD_DEVEL@/$build_devel/g; s/@SIMD@/$simd/g; s/@CUDAVER@/$cudaver/g; s/@SIMD_PRIORITY@/$simd_priority/g; s/@CUDA_PRIORITY@/$cuda_priority/g "
}

generate 1 1 sse2 30 1 9-0 50 1 > libsqaodc-sse2-cuda-9-0-devel.spec
generate 0 1 avx2 50 0 9-0  0 0 > libsqaodc-avx2.spec
generate 0 0 sse2  0 1 9-2 50 0 > libsqaodc-sse2-cuda-9-2.spec
