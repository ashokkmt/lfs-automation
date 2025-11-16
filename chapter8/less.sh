
./configure --prefix=/usr --sysconfdir=/etc

make -j$(nproc)
make check
make install