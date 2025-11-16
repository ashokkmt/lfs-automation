# SCRIPTS.md — Script Responsibilities

This document explains how each script in this project works.  
All scripts are written for **semi LFS automation** and are designed to be re-runnable, modular, and safe (with clear warnings where necessary).

---

## 1. `disksetup.sh`
Automates the process of preparing a storage device (USB / external HDD / virtual disk) for LFS installation.

### Purpose
- Asks for device name (e.g., `sdb`, `sda`, `nvme0n1`)
- Creates a new partition table
- Formats the partition as `ext2`
- Labels it for the LFS build
- Ensures consistent, repeatable disk setup

### ⚠️ WARNING
> **This script will erase all data on the selected device.**  
Make sure you select the correct device.

## 2. `download_*.sh`
Downloads all required LFS packages automatically using `packages.csv` and `patches.csv`.

### Purpose
- Reads package names, versions, and URLs from packages.csv
- Downloads all tarballs to `sources/`
- Verifies existing downloads to avoid duplicates
- Ensures your build has the exact package set needed


## 3. `lfs_part*.sh`
This is the primary automation script for the entire LFS build process.

### Purpose
- Serves as the "brain" of the entire project
- Calls other scripts in correct order
- Manages environment variables
- Mounts the LFS partition
- Executes all compilation scripts from different LFS chapters

## 4. `packageinstall.sh`
The `packageinstall.sh` script is the **core package automation engine** of the entire project.

While `lfs.sh` orchestrates the whole LFS build,  
`packageinstall.sh` is responsible for **actually compiling the packages** from each chapter.

It works by:
1. Reading package names (or folders) inside a chapter directory  
2. Extracting each package source tarball  
3. Running the corresponding `.sh` build script  
4. Logging everything  
5. Moving to the next package automatically

### Purpose
- Automates package extraction for each chapter  
- Runs packages in the correct order  
- Manages working directories  
- Handles log files

## 5. Chapter Package Scripts — `chapters<5,6,7,8,10>/*.sh`

Each chapter in LFS contains multiple packages that must be compiled in a specific order.  
For this automation system, **every package from every chapter** has its own dedicated script inside the appropriate `chapters<5,6,7,8,10>/` directory.

These scripts contain ONLY the commands required to:
- extract (if needed inside script)
- configure
- compile
- test
- install the respective LFS package.

They are minimal, modular, and run directly inside the controlled environment created by `packageinstall.sh`.

---

## 6. `insidechroot*.sh`

Each _insisderoot*.sh_ file is configured to compile different chatpers in order and separately. If you want to change order, check these file. They designed to run only inside change root environment or Host B's root environment.

---

## 7. `chroot_bash.sh`
This script helps you to enter target disk's root environment.

How to run:
```bash
sudo ./chroot_bash.sh <mount point of disk>
eg. sudo ./chroot_bash.sh /mnt/lfs  # This is mine 
```

## 8. `prepareroot.sh`
This script prepares the target LFS root environment before entering chroot.  

- Sets correct ownership (`root:root`) for important LFS directories  
- Creates required virtual filesystem mount points: `/dev`, `/proc`, `/sys`, `/run`  
- Binds the host system’s `/dev` and `/dev/pts`  
- Mounts `proc`, `sysfs`, and `tmpfs` for a working chroot environment  
- Ensures `/dev/shm` is properly mounted  

This script is used by `lfs_part2.sh` to create suitable environment and mounts for changing root.

## 9. `teardownroot.sh`
This script cleanly exits the LFS chroot environment.  
It:

- Unmounts `/dev/shm` and all other LFS virtual filesystems  
- Recursively unmounts `/mnt/lfs`  
- Restores original directory ownership back to the host user  
- Cleans leftover chroot-related temporary mounts  

This script runs at the end to unmount the points used for changing root. So that it doesnt create problem in Host A OS.
