
./configure --prefix=/usr \
    --disable-static \
    --sysconfdir=/etc \
    --docdir=/usr/share/doc/attr-$VERSION

make -j$(nproc)
make check
make install
