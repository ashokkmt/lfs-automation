
./configure --prefix=/usr --docdir=/usr/share/doc/bison-$VERSION

make -j$(nproc)
make check
make install