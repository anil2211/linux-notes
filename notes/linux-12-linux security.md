Step 12 – Linux Security

Goal: Learn how to secure Linux servers against unauthorized access, privilege escalation, and common security threats.

Reality in DevOps:

Most production servers are connected to the internet.

Every day they face:

Brute-force SSH attacks
Unauthorized login attempts
Malware and ransomware
Misconfigured permissions
Weak passwords
Outdated software with security vulnerabilities

A DevOps engineer's job isn't just to deploy applications—it's also to keep servers secure.

🎯 Learning Objectives

By the end of this step, you'll be able to:

Understand Linux security fundamentals
Apply the Principle of Least Privilege
Secure users and groups
Harden SSH
Manage file permissions securely
Configure firewalls
Understand SELinux and AppArmor
Monitor authentication logs
Secure software updates
Perform a basic Linux security audit
1. Linux Security Fundamentals

Linux security is based on multiple layers.

Internet
      │
      ▼
Firewall
      │
      ▼
SSH Security
      │
      ▼
User Permissions
      │
      ▼
File Permissions
      │
      ▼
Application Security

No single security feature is enough.

Security is built using multiple layers (Defense in Depth).

2. Principle of Least Privilege (PoLP)

Rule:

Give users only the permissions they need—nothing more.

Example:

❌ Bad

Developer → Root Access

✅ Good

Developer
      │
      ▼
sudo (Only Required Commands)

Never give root access unless absolutely necessary.

3. Keep Linux Updated

Many attacks target systems with known vulnerabilities.

Update package lists:

sudo apt update

Upgrade packages:

sudo apt upgrade

Upgrade everything:

sudo apt full-upgrade

Remove unused packages:

sudo apt autoremove
4. Secure User Accounts

List users:

cat /etc/passwd

List users with login shells:

grep "/bin/bash" /etc/passwd

Lock an account:

sudo usermod -L username

Unlock:

sudo usermod -U username

Expire an account:

sudo chage -E 2026-12-31 username
5. Strong Password Policies

Change password:

passwd

Check password expiration:

chage -l username

Best practices:

Minimum 12–16 characters
Uppercase
Lowercase
Numbers
Special characters

Never reuse passwords.

6. Secure SSH

View SSH configuration:

sudo nano /etc/ssh/sshd_config

Recommended settings:

Disable root login:

PermitRootLogin no

Disable password authentication (after configuring SSH keys):

PasswordAuthentication no

Use only SSH keys:

PubkeyAuthentication yes

Restart SSH:

sudo systemctl restart ssh
7. Configure Firewall (UFW)

Check status:

sudo ufw status

Enable firewall:

sudo ufw enable

Allow SSH:

sudo ufw allow ssh

Allow HTTP:

sudo ufw allow 80

Allow HTTPS:

sudo ufw allow 443

Deny a port:

sudo ufw deny 21

View numbered rules:

sudo ufw status numbered

Delete a rule:

sudo ufw delete 2
8. Check Open Ports

View listening ports:

ss -tulpn

Ask yourself:

Which ports are exposed?
Are they required?
Which process owns them?
9. File Permissions Review

Find world-writable files:

find / -type f -perm -002 2>/dev/null

Find SUID files:

find / -perm -4000 2>/dev/null

These commands are commonly used during security audits.

10. Monitor Authentication Logs

Ubuntu:

sudo tail -50 /var/log/auth.log

Using systemd:

journalctl -u ssh

Look for:

Failed logins
Repeated attempts
Unknown users
Suspicious IP addresses
11. Fail2Ban

Fail2Ban blocks IP addresses after repeated failed login attempts.

Install:

sudo apt install fail2ban

Check status:

sudo systemctl status fail2ban

This is a common protection against SSH brute-force attacks.

12. SELinux vs AppArmor

Linux uses Mandatory Access Control (MAC).

Ubuntu:

AppArmor

RHEL/CentOS:

SELinux

Check AppArmor:

sudo aa-status

Check SELinux:

getenforce

Possible SELinux modes:

Enforcing
Permissive
Disabled

You don't need to master them yet—understand their purpose.

13. Check Running Services

List enabled services:

systemctl list-unit-files --type=service --state=enabled

Disable unnecessary services:

sudo systemctl disable service_name

Stop immediately:

sudo systemctl stop service_name

Every unnecessary service increases the attack surface.

14. Security Audit Commands

Current user:

whoami

Logged-in users:

who

Last logins:

last

Failed login attempts:

lastb

Running processes:

ps aux

Listening ports:

ss -tulpn

Disk usage:

df -h

These commands are frequently used during incident investigations.

15. Linux Security Best Practices

✔ Use SSH keys instead of passwords.

✔ Disable root SSH login.

✔ Keep packages updated.

✔ Enable a firewall.

✔ Remove unused packages.

✔ Remove unused user accounts.

✔ Review logs regularly.

✔ Use the Principle of Least Privilege.

✔ Back up important data.

✔ Never expose unnecessary ports.

Practical Lab (60–90 Minutes)
Task 1

Update the system:

sudo apt update
sudo apt upgrade
Task 2

Check SSH configuration:

sudo nano /etc/ssh/sshd_config

Identify:

PermitRootLogin
PasswordAuthentication
Task 3

Enable UFW:

sudo ufw enable
sudo ufw status
Task 4

Allow:

sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
Task 5

View listening ports:

ss -tulpn
Task 6

Find world-writable files:

find / -type f -perm -002 2>/dev/null
Task 7

Review authentication logs:

sudo tail -50 /var/log/auth.log

or

journalctl -u ssh
Task 8

Install Fail2Ban:

sudo apt install fail2ban
sudo systemctl status fail2ban
Real DevOps Scenario
Problem

Your cloud VM is receiving thousands of SSH login attempts every hour.

Step 1

Review authentication logs:

journalctl -u ssh
Step 2

Disable root login.

Step 3

Enable SSH key authentication.

Step 4

Install and enable Fail2Ban.

Step 5

Verify UFW only allows:

22 (SSH)
80 (HTTP)
443 (HTTPS)
Step 6

Confirm only required services are running.

This layered approach significantly reduces the attack surface.

Biggest Mistakes Engineers Make
❌ Mistake 1

Leaving SSH password authentication enabled on internet-facing servers.

Use SSH keys whenever possible.

❌ Mistake 2

Running applications as root.

Run applications with dedicated, non-root service accounts.

❌ Mistake 3

Opening every firewall port "just to make it work."

Only expose the ports that are required.

❌ Mistake 4

Ignoring security updates.

Many attacks exploit vulnerabilities that already have available patches.

Free Resources
Linux Journey

Study:

Permissions
Users
Security
The Linux Foundation

Introduction to Linux

Read the chapters on security, users, permissions, and networking.

Ubuntu Server Guide

Read the sections on:

UFW
AppArmor
OpenSSH
Interview Questions
What is the Principle of Least Privilege?
Why should root SSH login be disabled?
What is UFW?
How do you allow HTTP traffic using UFW?
What is Fail2Ban?
What is the difference between SELinux and AppArmor?
How do you find open ports?
How do you find world-writable files?
Which log file contains SSH authentication logs?
How would you secure a newly created cloud VM before deploying an application?
Assignment

Perform a basic security audit of your Linux VM.

Run and understand:

sudo apt update
sudo ufw status
ss -tulpn
who
last
journalctl -u ssh
find / -type f -perm -002 2>/dev/null
systemctl list-unit-files --type=service --state=enabled

Then write a short report answering:

Which ports are open?
Which services are enabled?
Is the firewall enabled?
Is root SSH login disabled?
What security improvements would you make?
🎯 Mentor's Advice

Security is not something you add at the end of a project—it should be part of every deployment from the beginning.

When you provision a new server, follow this checklist:

Update the system.
Create a non-root user with sudo.
Configure SSH keys.
Disable root login.
Enable the firewall.
Install Fail2Ban.
Remove unnecessary services.
Review logs regularly.
Keep software updated.
Apply the Principle of Least Privilege.

These are the habits expected from DevOps engineers responsible for production infrastructure.

📌 What's Next?

Step 13 – Linux Performance Tuning

You'll learn:

CPU, memory, disk, and network performance analysis
Tools like top, htop, vmstat, iostat, sar, and iotop
Identifying performance bottlenecks
Optimizing Linux systems for production workloads
Troubleshooting high CPU, memory leaks, and I/O issues

This is where you'll begin thinking like an SRE who keeps systems fast, stable, and reliable.



