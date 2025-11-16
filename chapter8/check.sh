

./configure --prefix=/usr --disable-static

make -j$(nproc)
make check
make docdir=/usr/share/doc/check-$VERSION install