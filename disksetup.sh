#!/bin/bash

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT | grep -i "sd"
read -rp "Enter the LFS disk device name (e.g., sdb): " DEV  # enter usb name manually

export LFS_DISK="/dev/$DEV"

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"
