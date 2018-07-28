%define version 0.3.1
%define build_vpkg @BUILD_VPKG@
%define build_simd @BUILD_SIMD@
%define simd @SIMD@
%define simd_priority @SIMD_PRIORITY@
%define build_cuda @BUILD_CUDA@
%define cudaver @CUDAVER@
%define cuda_priority @CUDA_PRIORITY@
%define build_devel @BUILD_DEVEL@

%define platform_libdir %{_libdir}/%{_target_cpu}-%{_target_os}%{?_gnu}
%define libsqaodc_simd_libdir %{_libdir}/libsqaodc-%{simd}
%define libsqaodc_cuda_libdir %{_libdir}/libsqaodc-%{cudaver}
%define _unpackaged_files_terminate_build 0

Name:           sqaod
Version:        %{version}
Release:        1%{?dist}
Summary:        sqaodc

License:        Apache2
URL:            https://www.github.com/shinmorino/sqaod
Source0:        sqaod-%{version}.tar.gz

#BuildRequires:  
#Requires:       

%description
sqaod library

#
# sub packages
#

%if %{build_vpkg}
%package -n libsqaodc
Summary: sqaodc
Requires: libsqaodc-avx2 >= %{version} libsqaodc-sse2
%description -n libsqaodc
sqaodc CPU backend library (virtual pkg)
%endif

%if %{build_simd}
%package -n libsqaodc-%{simd}
Summary:        sqaodc
%description -n libsqaodc-%{simd}
sqaodc CPU backend library (%{simd})
%endif

# CUDA
%if %{build_cuda}
%package -n libsqaodc-cuda-%{cudaver}
Summary:        sqaodc CUDA backend library
Requires: cuda-curand-%{cudaver} cuda-cublas-%{cudaver} cuda-cudart-%{cudaver} libsqaodc >= %{version}
AutoReqProv: no
%description -n libsqaodc-cuda-%{cudaver}
sqaodc CUDA backend library
%endif

# devel
%if %{build_devel}
%package -n libsqaodc-devel
Summary:        developer files for sqaod
Requires: libsqaodc >= %{version}
%description -n libsqaodc-devel
developer files for sqaodc CPU backend library
%endif


# prep/build

%prep
%setup -q
./autogen.sh

%build
export SIMD_OPT=%{simd}
export CUDA_VER=`echo %{cudaver} | tr - .`
export CFLAGS=-O2

%if %{build_cuda}
  %configure --enable-cuda=/usr/local/cuda-${CUDA_VER}
%else
  %configure
%endif  

%make_build

%install
rm -rf $RPM_BUILD_ROOT
%make_install
find $RPM_BUILD_ROOT -name '*.la' -exec rm -f {} ';'

# move libsqaodc.so.x
mkdir -p ${RPM_BUILD_ROOT}/%{libsqaodc_simd_libdir}
mv ${RPM_BUILD_ROOT}/%{platform_libdir}/libsqaodc.so.* ${RPM_BUILD_ROOT}/%{libsqaodc_simd_libdir}

# move libsqaodc_cuda.so.x
%if %{build_cuda}
mkdir -p ${RPM_BUILD_ROOT}/%{libsqaodc_cuda_libdir}
mv ${RPM_BUILD_ROOT}/%{platform_libdir}/libsqaodc_cuda.so.* ${RPM_BUILD_ROOT}/%{libsqaodc_cuda_libdir}
%endif


# register alternatives

# cpu
%if %{build_simd}
%post -n libsqaodc-%{simd}
/sbin/alternatives --install %{_libdir}/libsqaodc.so.0 libsqaodc.so.0 %{libsqaodc_simd_libdir}/libsqaodc.so.0 %{simd_priority}
%endif

# cuda
%if %{build_cuda}
/sbin/alternatives --install %{_libdir}/libsqaodc_cuda.so.0 libsqaodc_cuda.so.0 %{libsqaodc_cuda_libdir}/libsqaodc_cuda.so.0 %{cuda_priority}
%endif

# pre uninstall

# cpu
%if %{build_simd}
%preun -n libsqaodc-%{simd}
/sbin/alternatives --remove libsqaodc.so.0 %{libsqaodc_simd_libdir}/libsqaodc.so.0
%endif

# cuda
%if %{build_cuda}
%preun -n libsqaodc-cuda-%{cudaver}
/sbin/alternatives --remove libsqaodc_cuda.so.0 %{libsqaodc_cuda_libdir}/libsqaodc_cuda.so.0
%endif

# post uninstall

# cpu
%if %{build_simd}
%postun -n libsqaodc-%{simd}
rm -rf %{libsqaodc_simd_libdir}
%endif

# cuda
%if %{build_cuda}
%postun -n libsqaodc-cuda-%{cudaver}
rm -rf %{libsqaodc_cuda_libdir}
%endif

# files

%if %{build_vpkg}
%files -n libsqaodc
%endif

%if %{build_simd}
%files -n libsqaodc-%{simd}
#%defattr(755, root, root)
%{libsqaodc_simd_libdir}/*.so.*
#%doc
%endif

%if %{build_cuda}
%files -n libsqaodc-cuda-%{cudaver}
%{libsqaodc_cuda_libdir}/*.so.*
%endif

%if %{build_devel}
%files -n libsqaodc-devel
#%defattr(755, root, root)
/usr/include/sqaodc
#%doc
%endif

%changelog
