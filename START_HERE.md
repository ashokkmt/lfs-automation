# START HERE — Prerequisites & First Steps for Running the LFS Automation

This document describes everything you must do **before** running the LFS automation scripts such as `disksetup.sh` or `lfs.sh`.

Follow these steps exactly.

---

## Prerequisite Things

### 1. Download the LFS Book  
Download the official LFS book (systemd version) from:

👉 https://www.linuxfromscratch.org/lfs/download.html  

Make sure you download the **systemd** edition (not SysV).

---

### 2. Update Your Host Libraries  
Install all required build tools:

```bash
sudo apt update
sudo apt install bash binutils bison coreutils diffutils findutils gawk gcc grep gzip m4 make patch perl python3 sed tar texinfo xz-utils
```

### 3. Clone the LFS Automation Repository

```bash
git clone https://github.com/ashokkmt/lfs-automation.git
cd lfs-automation
```

### 4. Create the LFS Mount Directory
Go to the root / directory of your host system and create:

```bash
sudo mkdir -pv /mnt/lfs
```

### ⚠️ WARNING
> **This /mnt/lfs folder is not the same as the cloned repository folder.**   
This is the actual mountpoint where the LFS disk will be mounted.


### 5. Plug In Your External Disk
Insert your pendrive or USB SSD/HDD that you will use to build and install LFS. **Make sure no important data is stored on the disk — it will be fully formatted.**

```bash
sudo ./disksetup.sh
```

Automatically detect all connected disks. Filter out your external disk.   
Enter your disk name like `sda or sdb`. After confirmation, it will handle partitioning and filesystem creation.

>It will be done once for a new disk.

## 6. Run the main build parts
This project splits the build into two main parts:

1. `lfs_part1.sh` — builds the initial toolchain on the target disk (Host B) using the host system (Host A). It compiles up to and including Chapter 6 (first toolchain stages).

2. `lfs_part2.sh` — switches environment into the target root (chroot to Host B) and compiles Chapter 7 and then Chapter 8 using the insidechroot*.sh scripts. It also provides the loop mechanism where you can add insidechroot4 and insidechroot5 for system configuration tasks.

### Run part 1 (toolchain up to chapter 6)
```bash
sudo ./lfs_part1.sh
```
**What it does:**
- It downloads packages and patches (calls download.sh or checks sources/)
- Sets up mounts
- Builds the cross toolchain for host B: chapters 5 & 6


### Run part 2 (chroot → chapter 7, 8, and system config)
```bash
sudo ./lfs_part2.sh
```
**What it does:**
- Mounts virtual filesystems for chroot (/proc, /sys, /dev, etc.)
- Enters the target root and runs chapter 7 builds
- Runs insidechroot*.sh scripts for chapter 8.
- You will typically see a loop in lfs_part2.sh that executes insidechroot1, insidechroot2, insidechroot3.

## Important:
### Run insidechroot4 & insidechroot5 Manually inside chroot (system config)
- insidechroot4 and insidechroot5 are intended to configure system settings (clock, locale, network, timezone, hostname, fstab, etc.).
- You should review and modify insidechroot4/insidechroot5 to match the LFS Book instructions for system configuration.

- **Recommended flow:**
    1. Run lfs_part2.sh as-is so it compiles chapters 7 and 8 using the existing insidechroot*.sh entries (commonly 1..3).

    2. After chapter 8 completes and you're inside chroot, run insidechroot4 and insidechroot5 manually to set locale/time/network:

        ```bash
        sudo ./chroot_bash.sh /mnt/lfs
        ```
    3. Above script will enter you into Host B's root environment from there you can manually modify and run files.

### Editing lfs_part2.sh to include 4 & 5 in the loop
If you want `lfs_part2.sh` to automatically run `insidechroot4` and `insidechroot5` in the same loop as the other inside-chroot scripts, edit `lfs_part2.sh`:
1. Open `lfs_part2.sh` in your editor.
2. Find the loop that iterates insidechroot*.sh.
3. Add `insidechroot4.sh` and `insidechroot5.sh` in the loop and don't forget to remove `insidechroot1-2.sh` from loop otherwise script will start compiling chapter 7 again.

`insidechroot5.sh` will compile your lnux kernel and create a grub config file to make your disk bootable and detectable in the bios.
