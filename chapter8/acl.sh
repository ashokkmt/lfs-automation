
./configure --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/acl-$VERSION

make -j$(nproc)
make check
make install
