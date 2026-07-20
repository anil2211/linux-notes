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
What does lsblk show?
What is the difference between df and du?
Why is df -h commonly used?
What is an inode?
What is the purpose of /etc/fstab?
What is the difference between mount and umount?
Why are UUIDs preferred over device names in /etc/fstab?
What is LVM, and why is it useful?
How would you troubleshoot a "No space left on device" error?
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