
CC=gcc ./configure --prefix=/usr -G -O3 -r

make -j$(nproc)
make test
make install