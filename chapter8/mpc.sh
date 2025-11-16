
./configure --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpc-$VERSION

make -j$(nproc)
make html
make check
make install
make install-html
