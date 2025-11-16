

./configure --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/xz-$VERSION

make -j$(nproc) \
&& make check \
&& make install