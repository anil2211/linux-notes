Step 4 – Package Management (APT, DPKG, YUM, DNF, RPM)

Goal: Learn how software is installed, updated, removed, and managed on Linux servers.

This is one of the most practical skills in DevOps because almost every tool (Docker, Kubernetes, Jenkins, Nginx, Terraform, etc.) is installed through a package manager.

🎯 Learning Objectives

By the end of this step, you'll be able to:

Understand what packages are.
Use apt and dpkg (Ubuntu/Debian).
Understand yum, dnf, and rpm (RHEL/CentOS).
Search, install, update, and remove software.
Troubleshoot common package issues.
1. What is a Package?

A package is a pre-built software bundle.

Think of it like installing an app from the Google Play Store or App Store.

Example packages:

Git
Docker
Nginx
Jenkins
Curl

Instead of downloading source code and compiling it yourself, Linux package managers do the work for you.

2. Package Managers
Distribution	Package Manager	Package Format
Ubuntu/Debian	apt	.deb
RHEL/CentOS 7	yum	.rpm
RHEL 8+/Rocky/AlmaLinux/Fedora	dnf	.rpm

Interview Tip: yum is largely replaced by dnf on newer Red Hat–based distributions, but you'll still encounter both.

3. Update Package Index

Before installing anything, refresh the package list:

sudo apt update

What it does:

Downloads the latest list of available packages.
Does not install updates.

Think of it as refreshing the app store catalog.

4. Upgrade Installed Packages
sudo apt upgrade

This upgrades installed software to newer versions.

5. Install a Package

Example:

sudo apt install git

Install multiple packages:

sudo apt install git curl wget
6. Verify Installation

Check the version:

git --version

Or locate the executable:

which git

Example:

/usr/bin/git
7. Search for Packages
apt search nginx

or

apt-cache search nginx
8. Remove a Package

Remove the package but keep configuration files:

sudo apt remove nginx
9. Completely Remove a Package
sudo apt purge nginx

This removes both the package and its configuration files.

10. Remove Unused Dependencies
sudo apt autoremove

This cleans up packages that were installed automatically but are no longer needed.

11. View Package Information
apt show git

You'll see:

Version
Dependencies
Description
Maintainer
Download size
12. List Installed Packages
apt list --installed

Search for a specific package:

apt list --installed | grep git
13. Install a Local .deb Package

If you have downloaded a .deb file:

sudo dpkg -i package.deb

If dependencies are missing:

sudo apt install -f
14. Useful dpkg Commands

List installed packages:

dpkg -l

Check if a package is installed:

dpkg -l | grep nginx

Find which package owns a file:

dpkg -S /usr/bin/git
15. RPM-Based Systems

If you work with Rocky Linux, AlmaLinux, RHEL, or CentOS:

Install:

sudo dnf install git

Search:

dnf search nginx

Update:

sudo dnf update

Remove:

sudo dnf remove nginx

Older systems may use:

yum install git
16. RPM Commands

Install a local package:

rpm -ivh package.rpm

Query installed packages:

rpm -qa

Package details:

rpm -qi git
17. Repository Basics

A repository (repo) is a trusted server that stores software packages.

When you run:

sudo apt install nginx

Linux downloads the package from a configured repository.

Repository configuration files are typically found in:

/etc/apt/sources.list
/etc/apt/sources.list.d/
🧪 Practical Lab (45–60 Minutes)
Task 1: Refresh the package index
sudo apt update
Task 2: Install utilities
sudo apt install git curl wget tree htop
Task 3: Verify installations
git --version
curl --version
tree --version
htop --version
Task 4: Find executable locations
which git
which curl
which tree
Task 5: Search for Nginx
apt search nginx
Task 6: View package information
apt show git
Task 7: Check installed packages
apt list --installed | grep git
Task 8: Remove a test package (optional)

If you installed a package just for practice:

sudo apt remove <package-name>

Then clean up:

sudo apt autoremove
🚨 Biggest Mistakes Engineers Make
❌ Mistake 1: Skipping apt update

Installing without refreshing package indexes can result in outdated or unavailable packages.

Correct sequence:

sudo apt update
sudo apt install <package>
❌ Mistake 2: Running apt upgrade blindly

On production servers, upgrades can change software versions and affect applications.

Best practice: Review what will be upgraded before confirming.

❌ Mistake 3: Mixing package managers

For example, using dpkg to install a package without resolving dependencies.

Better approach: Use apt whenever possible because it automatically handles dependencies.

🌍 Free Learning Resources
Linux Journey – Package Management section.
The Linux Foundation – Introduction to Linux (free).
Ubuntu Documentation on APT and package management.
freeCodeCamp Linux Course (YouTube).
💼 Real DevOps Scenario

A new Ubuntu server is provisioned.

One of the first tasks might be:

sudo apt update
sudo apt install -y git curl wget unzip htop nginx

These tools are commonly needed for deployments, monitoring, and troubleshooting.

🎤 Interview Questions
What is a Linux package?
What is the difference between apt update and apt upgrade?
What is the difference between apt remove and apt purge?
What is dpkg used for?
What is the difference between apt and dpkg?
What is a repository?
What command lists installed packages?
What command searches for available packages?
What is the package manager for RHEL 8 and later?
Why is apt install -f useful after a failed dpkg installation?
📝 Today's Assignment

Complete the lab and send me the output of:

git --version
which git
apt list --installed | grep git
apt show git

Also answer the 10 interview questions in your own words.

🎯 Mentor's Advice

Don't just memorize commands. Focus on understanding why you use them.

For example:

apt → Installs software and resolves dependencies automatically.
dpkg → Installs local .deb packages but doesn't automatically resolve dependencies.
apt update → Refreshes the package index.
apt upgrade → Installs newer versions of already installed packages.

Understanding these differences will help you troubleshoot real systems and answer interview questions confidently.