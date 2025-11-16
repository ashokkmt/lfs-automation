./configure --prefix=/usr \
    --build=$(sh support/config.guess) \
    --host=$LFS_TGT \
    --without-bash-malloc \
&& make \
&& make DESTDIR=$LFS install

mv $LFS/usr/bin/bash $LFS/bin/bash # not in lfs book
ln -sv bash $LFS/bin/sh
