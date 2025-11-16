
export LFS=""
cd /sources

cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file system mount-point type options dump fsck
# order
/dev/sda2 / ext2 defaults 1 1
/dev/sda1 /boot ext2 defaults 1 1
# End /etc/fstab
EOF

source packageinstall.sh 10 linux

grub-install --target i386-pc /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg
