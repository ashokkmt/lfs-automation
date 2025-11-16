
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-$VERSION

make -j$(nproc)
make -j1 check
make install