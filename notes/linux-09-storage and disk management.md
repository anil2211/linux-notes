Production Reality:
A large percentage of Linux incidents are caused by disk-related problems:

"No space left on device"
Application can't write logs
Database stopped because the disk is full
Server failed to boot because a filesystem wasn't mounted

A DevOps engineer should be able to diagnose these issues quickly.

Step 9 – Storage & Disk Management
🎯 Learning Objectives

By the end of this step, you'll be able to:

Understand disks, partitions, and filesystems.
Check disk usage.
Find large files and directories.
Mount and unmount filesystems.
Understand /etc/fstab.
Learn the basics of LVM.
Troubleshoot storage issues.
1. Disk vs Partition vs Filesystem

Think of it like this:

Hard Disk (Physical Drive)
│
├── Partition 1
├── Partition 2
└── Partition 3
        │
        ▼
Filesystem (ext4, xfs, etc.)
        │
        ▼
Files & Directories
Disk → Physical or virtual storage device.
Partition → A section of a disk.
Filesystem → The structure used to store files.
2. List Disks and Partitions

The most useful command:

lsblk

Example:

NAME   SIZE TYPE MOUNTPOINT
sda     50G disk
├─sda1   1G part /boot
└─sda2  49G part /

Important columns:

Column	Meaning
NAME	Device name
SIZE	Disk/partition size
TYPE	Disk or partition
MOUNTPOINT	Where it is mounted
3. Show Filesystem Usage
df -h

Example:

Filesystem      Size Used Avail Use%
/dev/sda2        50G  18G   30G  38%

-h means human-readable (GB/MB).

This is one of the first commands you'll run when someone says, "The server is out of space."

4. Find Large Directories
du -sh *

Example:

2.1G logs
800M backup
200M scripts

For a specific directory:

du -sh /var/log
5. Find the Largest Files
find / -type f -size +100M

This finds files larger than 100 MB.

6. Check Inode Usage

Sometimes a disk isn't full, but you've run out of inodes (common with millions of tiny files).

df -i

If inode usage is 100%, you may see "No space left on device" even when disk space is available.

7. Mount Points

Linux accesses storage by mounting it into the directory tree.

Example:

Disk
   │
   ▼
Mounted at:
/data

Check mounted filesystems:

mount

Or:

findmnt
8. Mount a Filesystem

Example:

sudo mount /dev/sdb1 /mnt

Now the contents of /dev/sdb1 are accessible under /mnt.

9. Unmount a Filesystem
sudo umount /mnt

Note: The command is umount, not unmount.

10. Persistent Mounts (/etc/fstab)

Temporary mounts disappear after reboot.

To mount automatically at boot, edit:

sudo nano /etc/fstab

Example entry:

UUID=xxxx-xxxx /data ext4 defaults 0 2

Always verify changes before rebooting.

11. Check Filesystem Type
df -Th

Example:

Filesystem Type Size Used
/dev/sda2 ext4 50G 18G

Common filesystems:

Filesystem	Usage
ext4	Default on Ubuntu
xfs	Common on RHEL
btrfs	Advanced features
vfat	USB drives
12. Create a Filesystem (Lab Only)

⚠️ Only practice on a spare disk or virtual machine.

Example:

sudo mkfs.ext4 /dev/sdb1

This formats the partition and erases existing data.

13. LVM (Logical Volume Manager)

LVM makes storage more flexible.

Without LVM:

Disk → Partition → Filesystem

With LVM:

Disk
 │
 ▼
Physical Volume (PV)
 │
 ▼
Volume Group (VG)
 │
 ▼
Logical Volume (LV)
 │
 ▼
Filesystem

Benefits:

Resize storage more easily.
Combine multiple disks.
Better suited for growing environments.
14. Useful LVM Commands (Awareness Level)

List physical volumes:

sudo pvs

List volume groups:

sudo vgs

List logical volumes:

sudo lvs

You don't need to master LVM today, but recognize these commands in interviews.

15. Check Block Device Information
sudo blkid

Example:

/dev/sda2: UUID="abcd-1234" TYPE="ext4"

UUIDs are commonly used in /etc/fstab.

🧪 Practical Lab (60 Minutes)
Task 1

View disks:

lsblk
Task 2

Check filesystem usage:

df -h
Task 3

Check filesystem types:

df -Th
Task 4

Check inode usage:

df -i
Task 5

Find the largest directories in your home folder:

du -sh ~/*
Task 6

Find files larger than 10 MB in your home directory:

find ~ -type f -size +10M
Task 7

View mounted filesystems:

findmnt
Task 8

View block device details:

sudo blkid
💼 Real DevOps Scenario
Problem

An application reports:

No space left on device
Step 1: Check disk usage
df -h
Step 2: Check inode usage
df -i
Step 3: Find large directories
du -sh /var/*
Step 4: Inspect logs
du -sh /var/log/*
Step 5: Identify large files
find /var/log -type f -size +100M

This structured approach helps you find the root cause instead of deleting files randomly.

🚨 Biggest Mistakes Engineers Make
❌ Mistake 1: Deleting files without understanding why they're large

Investigate the cause first. A rapidly growing log file may indicate an application problem.

❌ Mistake 2: Editing /etc/fstab without testing

An incorrect fstab entry can prevent a system from booting properly.

❌ Mistake 3: Formatting the wrong disk

Always confirm the target device with:

lsblk

before using commands like mkfs.

🌍 Free Learning Resources
Linux Journey – Filesystems & Storage.
The Linux Foundation – Introduction to Linux (Storage chapter).
Ubuntu Server Guide – Filesystems and storage.


🎤 Interview Questions
What is the difference between a disk, a partition, and a filesystem?
Disk
A disk is a physical or virtual storage device.
Examples:
HDD
SSD
NVMe

Linux names:
/dev/sda
/dev/sdb
/dev/nvme0n1

Partition
A partition is a logical division of a disk.
Example:
Disk
│
├── Partition 1
├── Partition 2
└── Partition 3

Linux:
/dev/sda1
/dev/sda2
/dev/sda3

Filesystem
A filesystem organizes how files and directories are stored.
Examples:
ext4
xfs
btrfs
FAT32
NTFS
Example:
mkfs.ext4 /dev/sda1
A disk is the physical storage device, a partition is a logical section of that disk, and a filesystem is the structure used to store and organize files on a partition.



What does lsblk show?
lsblk lists block devices.
Example:
lsblk

Output:
NAME   SIZE TYPE MOUNTPOINT
sda    100G disk
├─sda1  50G part /
└─sda2  50G part /home

Shows:
disks
partitions
mount points
sizes
Useful for checking storage layout.


What is the difference between df and du?
df	                                 du
Filesystem usage            	Directory/File usage
Shows free space	            Shows actual directory size
Reads filesystem metadata	    Reads files recursively
Example:

Filesystem:
df -h
Directory:
du -sh /var/log
Interview answer:
df reports disk usage of mounted filesystems, while du calculates disk usage of files and directories.


Why is df -h commonly used?
Because: df -h  uses -h which means Human Readable Instead of 1073741824 it shows 1G Much easier to understand.

What is an inode?
An inode is a data structure that stores metadata about a file.
It contains:
owner
permissions
timestamps
file size
disk block locations
It does not store the filename.
Check inode usage:df -i
Check inode number:ls -i

Interview answer:
An inode stores metadata about a file except its name and file content.

What is the purpose of /etc/fstab?
/etc/fstab
contains filesystems that should be mounted automatically during boot.
Example:UUID=1234-5678 / ext4 defaults 0 1
Check file:
cat /etc/fstab
Test:
sudo mount -a

What is the difference between mount and umount?
mount Attaches a filesystem.
Example:sudo mount /dev/sdb1 /mnt/data
umount Detaches a filesystem.
Example: sudo umount /mnt/data
Difference:mount	umount
Attach filesystem	Detach filesystem

Why are UUIDs preferred over device names in /etc/fstab?
Device names may change.
Example:
Today-/dev/sdb ,Tomorrow -/dev/sdc
UUIDs uniquely identify a filesystem and remain stable even if device names change.

What is LVM, and why is it useful?
LVM =Logical Volume Manager
It provides flexible storage management.
Without LVM
Disk
│
└── Partition
With LVM
Disk
│
└── Physical Volume
        │
        └── Volume Group
                │
                ├── Logical Volume
                ├── Logical Volume
                └── Logical Volume
Advantages:
Resize partitions online
Add disks easily
Snapshots
Flexible storage
Better management
Commands:
pvcreate
vgcreate
lvcreate
lvextend
resize2fs
Interview answer:LVM provides flexible disk management by allowing logical volumes to be resized, extended, and managed independently of physical disks.

How would you troubleshoot a "No space left on device" error?
Step 1 Check disk usage
df -h
Step 2 Check inode usage
df -i
Sometimes disk space is available but inodes are exhausted.
Step 3 Find large directories
du -sh /*
Step 4 Find large files
find / -type f -size +500M
Step 5 Clean logs
sudo journalctl --vacuum-time=7d
or
sudo truncate -s 0 /var/log/syslog
(Only if appropriate for your environment.)
Step 6 Remove unused packages
Ubuntu:
sudo apt autoremove
sudo apt clean
Step 7 Check deleted files still held open
sudo lsof | grep deleted
Restart the process if needed.
Step 8 Extend storage (if using LVM or cloud volumes)
Increase the filesystem size after extending the underlying volume.


Quick Interview Revision
Question	Short Answer
Disk	Physical storage device
Partition	Logical section of a disk
Filesystem	Structure that stores files
lsblk	Lists disks, partitions, mount points
df	Filesystem disk usage
du	Directory/file disk usage
df -h	Human-readable disk usage
Inode	Metadata structure for a file
/etc/fstab	Auto-mount configuration at boot
mount	Attach a filesystem
umount	Detach a filesystem
UUID	Stable filesystem identifier
LVM	Flexible logical volume management
"No space left on device"	Check df -h, df -i, du, large files, logs, and open deleted files

Interview Questions Based on These Commands
Q1. What does lsblk do?
Answer: Lists all block devices such as disks, partitions, and mount points.
Q2. Difference between df and du?
df → Shows filesystem disk usage.
du → Shows disk usage of files/directories.
Q3. What does df -i show?
Answer: Displays inode usage and availability.
Q4. What is blkid used for?
Answer: Displays filesystem UUIDs, labels, and filesystem types.
Q5. What is findmnt?
Answer: Displays the filesystem mount hierarchy and mount points.
Q6. Why are Windows drives shown as 9p?
Answer: WSL uses the 9P (Plan 9) protocol to expose Windows filesystems inside Linux.

📝 Today's Assignment

Run and understand the output of:

lsblk
df -h
df -Th
df -i
du -sh ~/*
find ~ -type f -size +10M
findmnt
sudo blkid

Then answer the 10 interview questions in your own words.

🎯 Mentor's Advice

When someone says:

"The disk is full."

Don't immediately delete files.

Follow this process:

Check disk usage → df -h
Check inode usage → df -i
Find large directories → du -sh
Locate large files → find
Determine why the files grew (logs, backups, dumps, etc.)
Clean up safely and verify the application still works.

This methodical approach is what interviewers and production environments expect from a DevOps engineer.

📌 Next Step

Step 10: Shell Scripting for DevOps

This is where you'll start automating Linux tasks using Bash. You'll learn:

Variables
Conditions (if)
Loops (for, while)
Functions
Reading user input
Error handling
Writing reusable automation scripts

These scripting skills are essential before moving on to tools like Ansible, Jenkins, Docker, and Kubernetes.