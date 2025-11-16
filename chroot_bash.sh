#!/bin/bash

export LFS="$1"
shift

if [ "$LFS" == "" ]; then
	exit 1
fi

cp -rf *.sh chapter* *.txt packages.csv "$LFS/sources"

chmod ugo+x preparechroot.sh
chmod ugo+x testing.sh
sudo ./preparechroot.sh "$LFS"
sudo ./testing.sh

sudo chroot "$LFS" /usr/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='(lfs chroot) \u:\w\$ ' \
	PATH=/bin:/usr/bin:/sbin:/usr/sbin \
	MAKEFLAGS="-j$(nproc)" \
	TESTSUITEFLAGS="-j$(nproc)" \
	/bin/bash --login

chmod ugo+x teardownchroot.sh
sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"