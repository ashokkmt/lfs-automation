#!/bin/bash

export LFS="$1"
export DIROWNER="$2"
export DIRGROUP="$3"


if [ "$LFS" == "" ]; then
	exit 1
fi

if [ -h $LFS/dev/shm ]; then
	rm -rf $LFS$(realpath /dev/shm)
else
	umount $LFS/dev/shm
fi

umount -R /mnt/lfs


chown -R $DIROWNER:$DIRGROUP $LFS/{boot,etc,bin,sbin,lib,usr,var} # changing permission to itself

case $(uname -m) in
 	x86_64) chown -R $DIROWNER:$DIRGROUP $LFS/lib64 ;;
esac
