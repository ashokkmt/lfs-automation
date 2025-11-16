
./configure --prefix=/usr \
    --disable-static \
    --enable-libgdbm-compat

make -j$(nproc)
make check
make install