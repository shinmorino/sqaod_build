rm -f build_deb/pydist/*
cd build_deb
./clean.sh
cd ..
rm -rf ./rpmbuild/BUILD/*
rm -rf ./rpmbuild/SOURCES/*
rm -rf build_deb/sqaod-*
rm -rf tests/sqaod-*
rm -f rpmbuild/SPECS/libsqaodc-*
