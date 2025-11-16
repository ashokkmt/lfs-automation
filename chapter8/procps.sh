
./configure --prefix=/usr \
    --docdir=/usr/share/doc/procps-ng-$VERSION \
    --disable-static \
    --disable-kill \
    --enable-watch8bit \
    --with-systemd

make

chown -R tester .
su tester -c "PATH=$PATH make check"

make install
