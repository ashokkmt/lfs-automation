
./configure --prefix=/usr \
    -docdir=/usr/share/doc/man-db-$VERSION \
    --sysconfdir=/etc \
    --disable-setuid \
    --enable-cache-owner=bin \
    --with-browser=/usr/bin/lynx \
    --with-vgrind=/usr/bin/vgrind \
    --with-grap=/usr/bin/

make -j$(nproc)
make check
make install