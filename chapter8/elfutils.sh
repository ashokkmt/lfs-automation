

./configure --prefix=/usr \
    --disable-debuginfod \
    --enable-libdebuginfo

make -j$(nproc)

make check
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a