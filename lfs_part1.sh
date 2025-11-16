#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT | grep -i "sd"
read -rp "Enter the LFS disk device name (e.g., sdb): " DEV # enter usb name manually

export LFS_DISK="/dev/$DEV"


sudo mount "${LFS_DISK}2" "$LFS" # mounting /dev/sda2 at /mnt/lfs
sudo chown -Rc $USER "$LFS" # ownership changed from root to USER now

mkdir -pv $LFS/{sources,tools,boot,etc,bin,sbin,lib,usr,var}

case $(uname -m) in
	x86_64) mkdir -pv $LFS/lib64 ;;
esac

cp -rf *.sh chapter* *.txt packages.csv "$LFS/sources" # moving all files to (B) sources now.
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"

echo "Starting downloading"
source download_1.sh
sleep 1
echo "-------------------------------- DOWNLOAD COMPLETE --------------------------------"
source download_2.sh
sleep 1
echo "-------------------------------- DOWNLOAD COMPLETE --------------------------------"


# CHAPTER 5
for package in binutils gcc linux-api-headers glibc; do
	source packageinstall.sh 5 $package
done

# CHAPTER 6
for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
	source packageinstall.sh 6 $package
done
