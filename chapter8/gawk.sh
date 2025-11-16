
sed -i 's/extras//' Makefile.in

./configure --prefix=/usr

make -j$(nproc)

chown -R tester .
su tester -c "PATH=$PATH make check"

rm -f /usr/bin/gawk-$VERSION
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1

install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} -t /usr/share/doc/gawk-$VERSION