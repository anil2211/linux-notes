tep 2 – Users, Groups & Permissions
🎯 Learning Objective

By the end of this step, you should be able to:

Understand Linux users and groups.
Create, modify, and delete users.
Manage groups.
Read and change file permissions.
Explain permission concepts in interviews.
Secure files and directories properly.
1. Why Do Users and Groups Exist?

Imagine a company with 100 employees.

Not everyone should have access to:

Database backups
Production servers
HR documents
Application configuration

Linux controls access using:

Users (individual identities)
Groups (collections of users)
Permissions (rules defining who can access what)

Think of it like this:

Company
│
├── User: Alice
├── User: Bob
├── User: Charlie
│
├── Group: Developers
├── Group: QA
├── Group: DevOps

A user can belong to multiple groups.

2. Check Your Current User
whoami

Example:

anil
Display Your User ID
id

Example:

uid=1000(anil)
gid=1000(anil)
groups=1000(anil),27(sudo)

Meaning:

UID → User ID
GID → Primary Group ID
groups → All groups the user belongs to

3. View All Users

Linux stores user information in:

cat /etc/passwd

Example:

root:x:0:0:root:/root:/bin/bash

Fields:

username
password placeholder
UID
GID
comment
home directory
default shell
4. View Groups
cat /etc/group
5. Create a User
sudo useradd -m devops

Set a password:

sudo passwd devops

Verify:

id devops
6. Create a Group
sudo groupadd developers
7. Add User to Group
sudo usermod -aG developers devops

Verify:

groups devops
8. Switch Users
su - devops

Return:

exit
9. Delete a User
sudo userdel -r devops

-r removes the home directory too.

10. Linux Permissions

Run:

ls -l

Example:

-rwxr-xr--

Break it down:

-
rwx
r-x
r--
Part	Meaning
-	File
d	Directory
rwx	Owner permissions
r-x	Group permissions
r--	Others permissions
11. Permission Values
Permission	Value
Read (r)	4
Write (w)	2
Execute (x)	1

Examples:

7 = rwx
6 = rw-
5 = r-x
4 = r--
0 = ---
12. Change Permissions

Create a file:

touch project.sh

Make it executable:

chmod +x project.sh

Or use numeric mode:

chmod 755 project.sh

Meaning:

Owner = 7 = rwx
Group = 5 = r-x
Others = 5 = r-x
13. Change Owner
sudo chown devops project.sh

Owner and group together:

sudo chown devops:developers project.sh
14. Change Group
sudo chgrp developers project.sh
15. Common Permission Modes
Mode	Meaning
777	Everyone can do everything (avoid in production)
755	Executable programs
644	Regular files
700	Private scripts
600	Secrets (SSH keys, passwords)
Practical Lab (30–45 Minutes)

Complete these tasks in your Linux lab:

Create a new group named devops.
Create two users: alice and bob.
Add both users to the devops group.
Create a directory named project.
Inside it, create a file named deploy.sh.
Change the owner of deploy.sh to alice.
Change its group to devops.
Set permissions to 755.

Verify everything with:

ls -l deploy.sh
Switch to alice and confirm the file is executable.

sudo groupadd devops

sudo useradd -m alice
sudo useradd -m bob

sudo usermod -aG devops alice
sudo usermod -aG devops bob

mkdir project
cd project

touch deploy.sh

sudo chown alice:devops deploy.sh

sudo chmod 755 deploy.sh

id alice
id bob
ls -l deploy.sh
tree


Biggest Mistakes Engineers Make

❌ Using chmod 777 to "fix" permission issues.

Why it's bad:

Anyone can read, modify, or execute the file.
It introduces major security risks.
It's considered poor practice in production.

Instead:

Understand who actually needs access.
Use the least permissive settings that allow the required work (for example, 644, 755, 600, or 700).


Practice each command yourself rather than only watching videos.

-----------------------------------------------------------------------------------
Interview Questions

Try answering these without looking them up:
-----------------------------------------------------------------------------------
What is the difference between a user and a group?
User:
A user represents an individual account in Linux.
Each user has a username, password, UID, home directory, and permissions.

Example:
alice
bob
devops_anil

Group:
A group is a collection of users.
Groups make it easier to manage permissions for multiple users at once.

Example:
devops group
 ├── alice
 └── bob
Instead of giving permissions to each user separately, you give permissions to the group.
-----------------------------------------------------------------------------------

What do UID and GID represent?
UID (User ID):
A unique numeric identifier assigned to a user.
Example:
alice:x:1001
Here:
1001 = UID

GID (Group ID):
A unique numeric identifier assigned to a group.
Example:
devops:x:1002
Here:
1002 = GID
Linux uses UID and GID internally to identify users and groups.
-----------------------------------------------------------------------------------
What does chmod 755 mean?
chmod changes file permissions.
chmod 755 deploy.sh
755
│││
││└── Others
│└─── Group
└──── Owner
rwxr-xr-x

Means:

User	Permission
Owner	Read, write, execute
Group	Read, execute
Others	Read, execute
-----------------------------------------------------------------------------------

What is the difference between chown and chmod?
chown → Change ownership
Changes the user or group that owns a file.
Example:
chown alice:devops deploy.sh
Result:
Owner: alice
Group: devops

chmod → Change permissions
Changes access permissions.
Example:
chmod 755 deploy.sh
Result:
Owner: rwx
Group: r-x
Others: r-x

Difference:
Command	Changes
chown	Owner/group
chmod	Read/write/execute permissions
-----------------------------------------------------------------------------------

Why is chmod 777 discouraged?
chmod 777 gives:rwxrwxrwx
User	Permission
Owner	Full access
Group	Full access
Others	Full access

Problems:
Any user can modify or delete the file.
Can allow unauthorized changes.
Creates security risks.
Violates the principle of least privilege
chmod 777 important_script.sh
Any user on the system could modify the script.
-----------------------------------------------------------------------------------

What is stored in /etc/passwd?
/etc/passwd stores information about user accounts.
alice:x:1001:1001:Alice:/home/alice:/bin/bash
username:
password placeholder:
UID:
GID:
comment:
home directory:
login shell

Field	Value
Username	alice
UID	1001
GID	1001
Home	/home/alice
Shell	/bin/bash
Passwords are not stored here in modern Linux systems; they are stored in /etc/shadow.
-----------------------------------------------------------------------------------

What is stored in /etc/group?
/etc/group stores group information.
Example:
devops:x:1002:alice,bob
Fields:
group name:
password placeholder:
GID:
members:
Example:
Field	Value
Group name	devops
GID	1002
Members	alice,bob
-----------------------------------------------------------------------------------
How do you add a user to an existing group?
sudo usermod -aG groupname username
-a → append (do not remove existing groups)
-G → supplementary group

Another command:
sudo gpasswd -a alice devops
-----------------------------------------------------------------------------------
What command displays the groups a user belongs to?
For the current user:
groups
devops_anil sudo docker
For a specific user:
groups alice
uid=1001(alice) gid=1001(alice) groups=1001(alice),1002(devops)
-----------------------------------------------------------------------------------

What do the permissions rwxr-xr-- allow for the owner, group, and others?
Break it into three sections:
rwx r-x r--
│   │   │
│   │   └── Others
│   └────── Group
└────────── Owner
Permissions:
User	Permission	Meaning
Owner	rwx	Read, write, execute
Group	r-x	Read, execute
Others	r--	Read only
-----------------------------------------------------------------------------------

Quick Interview Revision
Topic	Command/Concept
User ID	UID
Group ID	GID
Change owner	chown
Change permissions	chmod
Add user to group	usermod -aG
View user groups	groups / id
User database	/etc/passwd
Group database	/etc/group
Full permissions	777 (avoid)
Common executable permission	755
-----------------------------------------------------------------------------------
📋 Today's Assignment
Complete the practical lab.
Paste the output of:
id alice
groups alice
ls -l project/deploy.sh
Answer the 10 interview questions in your own words.