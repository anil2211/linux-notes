Step 1 — Linux File System Deep Dive
Objective

Understand how Linux organizes files and directories so you can confidently navigate any server.

Concept (Simple Explanation)

Unlike Windows, Linux has a single directory tree that starts at the root directory:

/

Everything—files, disks, devices, and user home directories—appears somewhere under /.

Some important directories you'll encounter often:

Directory	Purpose
/	    Root of the filesystem
/home	User home directories
/root	Root user's home
/etc	System configuration files
/var	Logs, caches, application data
/tmp	Temporary files
/usr	Installed programs and libraries
/bin	Essential user commands
/sbin	System administration commands
/opt	Optional third-party software
/dev	Device files
/proc	Virtual filesystem with process and kernel information

A helpful way to remember this:

Configuration → /etc
Logs → /var/log
User files → /home
Temporary data → /tmp

Commands to Learn

Practice these until you can use them without looking them up:

pwd
ls
ls -la
cd
mkdir
rmdir
touch
cp
mv
rm
find
locate
tree

Use man <command> whenever you're unsure what a command does.
Command	How it works
find	Searches the actual filesystem
locate	Searches a pre-built database

Practical Exercise

Inside your ~/linux-lab directory:

Create this structure:
linux-lab/
├── projects
│   ├── project1
│   └── project2
├── notes
└── scripts
Add a file named README.md to each project.
Copy one README to another location.
Rename one project directory.
Delete the copied file.
Find all README.md files using find.
Display the final directory tree with tree.

Complete command sequence

You can run all commands together:

mkdir projects notes scripts
mkdir projects/project1 projects/project2

touch projects/project1/README.md
touch projects/project2/README.md

cp projects/project1/README.md notes/

mv projects/project2 projects/project-two

rm notes/README.md

find . -name "README.md"

tree

This exercise practices the main Linux file operations:

mkdir → create directories
touch → create files
cp → copy files
mv → rename/move
rm → delete
find → search
tree → visualize structure
