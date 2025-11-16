#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT | grep -i "sd"
read -rp "Enter the LFS disk device name (e.g., sdb): " DEV # enter usb name manually

export LFS_DISK="/dev/$DEV"

mkdir -pv $LFS/{sources,tools,boot,etc,bin,sbin,lib,usr,var}

case $(uname -m) in
	x86_64) mkdir -pv $LFS/lib64 ;;
esac

cp -rf *.sh chapter* *.txt packages.csv "$LFS/sources" # moving all files to (B) sources now.
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"


chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot*.sh  #to create passwd file in /etc for adding users
chmod ugo+x teardownchroot.sh
chmod ugo+x chap*_end.sh   #to delete the unused files after completing chapter 7 and 8

sudo ./preparechroot.sh "$LFS"
 
# "/sources/insidechroot4.sh" "/sources/insidechroot5.sh"
for script in "/sources/insidechroot.sh" "/sources/insidechroot2.sh" "/sources/insidechroot3.sh" ; do
	echo "NOW ENTERING $script CHROOT ENVIRONMENT..."
	sleep 2
	sudo chroot "$LFS" /usr/bin/env -i \
		HOME=/root \
		TERM="$TERM" \
		PS1="(lfs chroot) \u:\w\$ " \
		PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
		/bin/bash --login +h -c "$script"
done

sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"


# More CHROOT enter examples
# TO RUN INSIDECHROOT FILE ALONE IN CHROOT ENV
# sudo chroot "$LFS" /usr/bin/env -i \
# 		HOME=/root \
# 		TERM="$TERM" \
# 		PS1="(lfs chroot) \u:\w\$" \
# 		PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
# 		/bin/bash --login +h -c "/sources/chapter7_end.sh" 

# TO RUN TERMINAL IN CHROOT ENV
# sudo chroot "$LFS" /usr/bin/env -i \
# 	HOME=/root \
# 	TERM="$TERM" \
# 	PS1='(lfs chroot) \u:\w\$ ' \
# 	PATH=/usr/bin:/usr/sbin \
# 	MAKEFLAGS="-j$(nproc)" \
# 	TESTSUITEFLAGS="-j$(nproc)" \
# 	/bin/bash --login
