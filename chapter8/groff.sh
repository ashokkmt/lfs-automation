
PAGE=A4 ./configure --prefix=/usr

make -j1
make check
make install
