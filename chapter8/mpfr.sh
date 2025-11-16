
./configure --prefix=/usr \
    --disable-static \
    --enable-thread-safe \
    --docdir=/usr/share/doc/mpfr-$VERSION

make -j$(nproc)
make html
make check
make install
make install-html