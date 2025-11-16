
./configure --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION

make -j$(nproc)
make -j$(($(nproc)>4?$(nproc):4)) check
make install