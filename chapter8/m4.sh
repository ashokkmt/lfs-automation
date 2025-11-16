
./configure --prefix=/usr CFLAGS="-Wno-null-dereference"

make -j$(nproc)
make check
make install
