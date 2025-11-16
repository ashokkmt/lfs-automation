
./configure --prefix=/usr \
    --enable-hashes=strong,glibc \
    --enable-obsolete-api=no \
    --disable-static \
    --disable-failure-tokens

make -j$(nproc)
make check
make install

make distclean
./configure --prefix=/usr \
 --enable-hashes=strong,glibc \
 --enable-obsolete-api=glibc \
 --disable-static \
 --disable-failure-tokens
make
cp -av --remove-destination .libs/libcrypt.so.1* /usr/lib
