
./configure --prefix=/usr \
    --disable-static \
    --with-gcc-arch

make -j$(nproc)
make check
make install