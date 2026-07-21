# 🐧 Linux for DevOps: The Comprehensive Roadmap
> A structured, hands-on learning path designed to take you from basic Linux usage to Production-level SRE (Site Reliability Engineering) skills. This guide is tailored for DevOps Engineers with **0-2 years of experience**.

---

## 🗺️ Learning Path Overview
This roadmap is designed to be tackled sequentially. Each step builds upon the previous one, moving from basic environment setup to complex production troubleshooting.

| Step | Topic | Focus | Why it Matters for DevOps |
| :--- | :--- | :--- | :--- |
| **0** | **Linux Mindset & Environment** | Lab Setup | Foundation for safe experimentation. |
| **1** | **File System Deep Dive** | Navigation & Org | Understanding where tools and configs live. |
| **2** | **Users, Groups & Permissions** | Security | The core of the Principle of Least Privilege. |
| **3** | **Process Management** | Resource Monitoring | Troubleshooting "hung" or "slow" servers. |
| **4** | **Package Management** | Software Lifecycle | Installing and updating tools (Docker, Nginx). |
| **5** | **Services & systemd** | Daemon Management | Ensuring apps start and stay running. |
| **6** | **Logs & Troubleshooting** | Root Cause Analysis | The primary way to diagnose production failures. |
| **7** | **Networking for DevOps** | Connectivity | Diagnosing "Website Down" or "API Timeout" issues. |
| **8** | **SSH & Remote Management** | Secure Access | The primary gateway to cloud servers. |
| **9** | **Storage & Disk Management** | Data Persistence | Handling "Disk Full" and LVM resizing. |
| **10** | **Shell Scripting (Bash)** | Automation | Converting manual tasks into reusable scripts. |
| **11** | **Cron & Task Scheduling** | Recurring Jobs | Automating backups and health checks. |
| **12** | **Linux Security Hardening** | Defense in Depth | Protecting servers from brute-force and exploits. |
| **13** | **Performance Tuning** | SRE Observability | Identifying CPU, Memory, and I/O bottlenecks. |
| **14** | **Production Troubleshooting**| SRE Mindset | Systematic approach to resolving critical incidents. |
| **15** | **Real-World Projects** | Job Readiness | Portfolio building through production-grade labs. |

---

## 🚀 Detailed Learning Steps

### Step 0: Build Your Linux Lab
**Objective:** Create a safe, isolated environment where you can experiment and break things without affecting your host OS.

#### 💡 Concept
Think of Linux as a new city. Reading about it isn't enough; you must walk the streets, get lost, and find your way back. This is the "DevOps Mindset": **Learn by Doing**.

#### 🛠️ Setup Options
| Option | Recommended For | Tool |
| :--- | :--- | :--- |
| **Option 1** | Beginners (Safe) | VirtualBox $\to$ Ubuntu Server 24.04 LTS |
| **Option 2** | Performance | VMware Workstation $\to$ Ubuntu Server |
| **Option 3** | Fast Iteration | WSL2 (Windows Subsystem for Linux) |

**Quick Setup for WSL2 (via VS Code):**
1. Press `Ctrl + Shift + X` $\to$ Install **WSL** extension.
2. Press `Ctrl + Shift + P` $\to$ Run **WSL: Enable**.

#### 💻 Practical Exercise
```bash
# Create a dedicated practice area
mkdir ~/linux-lab && cd ~/linux-lab
mkdir practice scripts notes projects

# Install essential DevOps toolset
sudo apt update
sudo apt install curl wget git vim htop tree net-tools unzip zip -y

# Verify structure
tree
```

---

### Step 1: Linux File System Deep Dive
**Objective:** Confidently navigate any Linux server by understanding the standard directory structure.

#### 💡 Concept
Linux uses a single hierarchical tree starting at the **root (/)**. Everything—including physical disks and devices—is represented as a file.

#### 📂 Key Directory Reference
| Directory | Purpose | DevOps Use-Case |
| :--- | :--- | :--- |
| `/` | Root | The starting point of the system. |
| `/etc` | Configuration | Editing `nginx.conf` or `ssh_config`. |
| `/var/log` | System Logs | Troubleshooting app crashes via `syslog`. |
| `/home` | User Data | Where user-specific scripts and configs live. |
| `/tmp` | Temporary | Storing transient data (cleaned on reboot). |
| `/bin` & `/sbin` | Binaries | Where essential system commands reside. |
| `/opt` | Optional | Installing third-party software (e.g., Google Cloud SDK). |
| `/proc` | Process Info | Virtual FS providing kernel/process statistics. |

#### 🛠️ Command Cheat Sheet
| Command | Description | Example |
| :--- | :--- | :--- |
| `pwd` | Print Working Directory | `pwd` $\to$ `/home/anil/linux-lab` |
| `ls -la` | List all files (inc. hidden) | `ls -la /etc` |
| `mkdir` | Create directory | `mkdir projects` |
| `touch` | Create empty file | `touch README.md` |
| `cp` | Copy file/folder | `cp config.txt config.bak` |
| `mv` | Move or Rename | `mv project1 project-two` |
| `rm` | Remove file/folder | `rm -rf temp_folder` |
| `find` | Search filesystem | `find . -name "README.md"` |

---

### Step 2: Users, Groups & Permissions
**Objective:** Implement the **Principle of Least Privilege (PoLP)** to secure system access.

#### 💡 Concepts
- **Users:** Individual identities (e.g., `alice`, `bob`).
- **Groups:** Collections of users to manage permissions at scale (e.g., `developers`, `devops`).
- **Permissions:** Rules defining who can **Read (r)**, **Write (w)**, or **Execute (x)**.

#### 🔐 Understanding Permission Strings
Example: `-rwxr-xr--`
- **First char**: `-` (File) or `d` (Directory).
- **Next 3 (rwx)**: Owner permissions.
- **Middle 3 (r-x)**: Group permissions.
- **Last 3 (r--)**: Others permissions.

**Numeric Mode Mapping:**
- `Read (r)` = 4 | `Write (w)` = 2 | `Execute (x)` = 1
- `7` (4+2+1) $\to$ `rwx`
- `5` (4+0+1) $\to$ `r-x`
- `6` (4+2+0) $\to$ `rw-`

#### 🛠️ Essential Commands
| Action | Command | Example |
| :--- | :--- | :--- |
| **Create User** | `sudo useradd -m <user>` | `sudo useradd -m devops` |
| **Set Password**| `sudo passwd <user>` | `sudo passwd devops` |
| **Create Group**| `sudo groupadd <group>` | `sudo groupadd developers` |
| **Assign Group**| `sudo usermod -aG <group> <user>`| `sudo usermod -aG developers devops` |
| **Change Mode** | `chmod <mode> <file>` | `chmod 755 deploy.sh` |
| **Change Owner**| `chown <user>:<group> <file>` | `sudo chown alice:devops deploy.sh` |

> ⚠️ **Common Pitfall:** Avoid using `chmod 777`. It gives everyone full control, creating a massive security hole. Use the least permission necessary (e.g., `644` for files, `755` for scripts).

#### 🎤 Interview Preparation
**Q: What is the difference between `chown` and `chmod`?**
- **`chown`**: Changes **who** owns the file (Owner/Group).
- **`chmod`**: Changes **what** the owners can do with the file (Read/Write/Execute).

**Q: What does `chmod 755` mean?**
- **Owner**: Read, Write, Execute (7)
- **Group**: Read, Execute (5)
- **Others**: Read, Execute (5)

---

### Step 3: Process Management
**Objective:** Monitor system resources and manage running applications to ensure stability.

#### 💡 Concept
A **Process** is a running instance of a program. Every process has a unique **PID (Process ID)**.

#### 🛠️ Monitoring & Control Tools
| Tool | Purpose | Command |
| :--- | :--- | :--- |
| **`ps`** | Static snapshot of processes | `ps -ef` |
| **`top` / `htop`**| Real-time resource monitor | `htop` |
| **`free`** | Memory/RAM usage | `free -h` |
| **`uptime`** | System load average | `uptime` |
| **`kill`** | Stop a process by PID | `kill <PID>` |
| **`pkill`** | Stop a process by name | `pkill nginx` |

#### 💻 Practical Lab: Background Jobs
```bash
# 1. Start a process in the background
sleep 500 & 

# 2. View current background jobs
jobs

# 3. Find the PID of the process
pgrep sleep

# 4. Bring it to foreground
fg %1

# 5. Suspend it (Ctrl+Z) and send back to background
bg
```

> ⚠️ **SRE Tip:** Use `kill -9` (SIGKILL) only as a last resort. It forces the process to stop immediately without cleaning up resources. Always try a standard `kill` (SIGTERM) first.

---

### Step 4: Package Management
**Objective:** Install, update, and manage software professionally across different Linux distributions.

#### 📦 Package Manager Comparison
| Distribution | Package Manager | Format | Example Install |
| :--- | :--- | :--- | :--- |
| **Ubuntu / Debian** | `apt` / `dpkg` | `.deb` | `sudo apt install git` |
| **RHEL / CentOS / Rocky**| `dnf` / `yum` / `rpm` | `.rpm` | `sudo dnf install git` |

#### 🛠️ Common `apt` Workflow
```bash
sudo apt update               # Refresh package index (catalog)
sudo apt upgrade              # Update existing software
sudo apt install <package>    # Install new software
sudo apt remove <package>     # Remove software (keeps config)
sudo apt purge <package>      # Remove software AND config files
sudo apt autoremove           # Clean up unused dependencies
```

---

### Step 5: Services & systemd
**Objective:** Manage background daemons (services) that power the infrastructure.

#### 💡 Concept
**systemd** is the system and service manager. It is the first process started by the kernel (**PID 1**) and is responsible for starting all other services.

#### 🛠️ Service Management Matrix
| Action | Command | Purpose |
| :--- | :--- | :--- |
| **Start** | `sudo systemctl start <service>` | Start the service immediately. |
| **Stop** | `sudo systemctl stop <service>` | Stop the service immediately. |
| **Restart** | `sudo systemctl restart <service>` | Full stop and start (resets state). |
| **Reload** | `sudo systemctl reload <service>` | Update config without stopping service. |
| **Enable** | `sudo systemctl enable <service>` | Set to start automatically at boot. |
| **Status** | `systemctl status <service>` | Check if the service is active/failed. |
| **Logs** | `journalctl -u <service>` | View systemd journal logs for a service. |

#### 🎤 Interview Prep
**Q: What is the difference between `restart` and `reload`?**
- **Restart**: Stops the process and starts it again. This causes a brief downtime.
- **Reload**: Tells the process to read its configuration file again without shutting down. This is "zero-downtime" for configuration updates.

---

### Step 6: Linux Logs & Troubleshooting
**Objective:** Stop guessing and start using evidence. Use logs to find the root cause of failures.

#### 📂 The Log Map
| Log File | Content | Use-Case |
| :--- | :--- | :--- |
| `/var/log/syslog` | General system events | Overall system health. |
| `/var/log/auth.log` | SSH & Auth events | Detecting brute-force attacks. |
| `/var/log/nginx/error.log`| Nginx Errors | Debugging 500/502/504 errors. |
| `journalctl` | systemd journal | Service-specific failures. |

#### 🛠️ Log Analysis Toolkit
```bash
# Watch logs in real-time
tail -f /var/log/syslog

# Search for "ERROR" (case-insensitive)
grep -i "error" /var/log/syslog

# View the last 50 lines of a service log
journalctl -u nginx -n 50

# Filter logs since a specific time
journalctl --since "1 hour ago"
```

---

### Step 7: Linux Networking for DevOps
**Objective:** Diagnose connectivity issues between servers, containers, and APIs.

#### 🌐 Networking Toolkit
| Command | Purpose | Example |
| :--- | :--- | :--- |
| `ip a` | Show IP and Interface status | `ip a` |
| `ping` | Test basic reachability (ICMP) | `ping 8.8.8.8` |
| `curl -I` | Test HTTP response headers | `curl -I https://google.com` |
| `ss -tulpn` | Show all listening ports | `sudo ss -tulpn` |
| `dig` / `nslookup`| DNS resolution check | `dig google.com` |
| `nc` | Test specific port connectivity | `nc -zv google.com 443` |

#### 💼 Real-World Scenario: "Website is Down"
**Troubleshooting Sequence:**
1. `systemctl status nginx` $\to$ Is the service running?
2. `ss -tulpn | grep :80` $\to$ Is it listening on port 80?
3. `curl http://localhost` $\to$ Does it work locally?
4. `ip a` $\to$ Does the server have the correct IP?
5. `nslookup example.com` $\to$ Is DNS resolving the domain?
6. `journalctl -u nginx` $\to$ What do the logs say?

---

### Step 8: SSH & Remote Management
**Objective:** Securely access and manage remote cloud infrastructure.

#### 🔑 Key-Based Authentication
**The Golden Rule:** Never use passwords for production servers. Use SSH Keys.

- **Private Key (`id_rsa`)**: Stays on your laptop. **NEVER SHARE**.
- **Public Key (`id_rsa.pub`)**: Copied to the server.

#### 🛠️ SSH Workflow
```bash
# 1. Generate keys
ssh-keygen -t ed25519

# 2. Copy public key to server (Passwordless login)
ssh-copy-id ubuntu@server-ip

# 3. Create a config shortcut (~/.ssh/config)
# Host prod-web
#   HostName 1.2.3.4
#   User ubuntu
#   IdentityFile ~/.ssh/id_ed25519

# 4. Connect using the shortcut
ssh prod-web
```

---

### Step 9: Storage & Disk Management
**Objective:** Manage partitions and filesystems to prevent "Disk Full" outages.

#### 🛠️ Storage Monitoring
| Command | Purpose | Key Metric |
| :--- | :--- | :--- |
| `lsblk` | List block devices | Partition layout. |
| `df -h` | Disk space usage | `% Use` (Look for 100%). |
| `df -i` | Inode usage | Number of files (can be full even with space). |
| `du -sh *` | Directory size | Find which folder is eating space. |

#### ⚙️ The LVM Concept (Logical Volume Manager)
LVM allows you to treat multiple physical disks as one giant pool of storage, which can be resized on the fly without rebooting.
`Physical Volume (PV)` $\to$ `Volume Group (VG)` $\to$ `Logical Volume (LV)` $\to$ `Filesystem`.

---

### Step 10: Shell Scripting (Bash) for DevOps
**Objective:** Move from "Linux Admin" to "DevOps Engineer" by automating everything.

#### 💡 Core Scripting Components
- **Shebang**: `#!/bin/bash` (Tells the OS to use Bash).
- **Variables**: `NAME="DevOps"` $\to$ accessed as `$NAME`.
- **Logic**: `if [ condition ]; then ... fi`
- **Loops**: `for i in {1..5}; do ... done`
- **Exit Codes**: `$?` (0 = Success, Non-zero = Error).

#### 💻 Example: Simple Service Monitor
```bash
#!/bin/bash
SERVICE="nginx"
if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is running"
else
    echo "$SERVICE is DOWN! Sending alert..."
    # Add alert command here
fi
```

---

### Step 11: Cron Jobs & Task Scheduling
**Objective:** Automate recurring maintenance tasks (backups, cleanup).

#### ⏰ Cron Expression Format
`* * * * * command`
- `Minute` (0-59)
- `Hour` (0-23)
- `Day of Month` (1-31)
- `Month` (1-12)
- `Day of Week` (0-7)

**Common Schedules:**
- Every 5 mins: `*/5 * * * *`
- Every day at 2 AM: `0 2 * * *`
- Every Sunday: `0 0 * * 0`

> ⚠️ **Best Practice:** Always use **Absolute Paths** in cron (e.g., `/home/user/scripts/backup.sh` instead of `./backup.sh`) because cron runs with a limited environment.

---

### Step 12: Linux Security Hardening
**Objective:** Reduce the attack surface of your servers.

#### 🛡️ Hardening Checklist
- [ ] **SSH**: Disable `PermitRootLogin` and `PasswordAuthentication`.
- [ ] **Firewall**: Enable `ufw` and only open required ports (22, 80, 443).
- [ ] **Users**: Apply the **Principle of Least Privilege** (no root for devs).
- [ ] **Updates**: Run `sudo apt update && sudo apt upgrade` regularly.
- [ ] **IDS**: Install `fail2ban` to stop SSH brute-force attacks.

---

### Step 13: Performance Tuning (SRE Level)
**Objective:** Identify bottlenecks in CPU, Memory, Disk, and Network.

#### 📈 The Observability Stack
| Metric | Primary Tool | What to look for? |
| :--- | :--- | :--- |
| **CPU** | `top` / `htop` | High `%user` or `%system`. |
| **Load** | `uptime` | Load average > Number of CPU cores. |
| **Memory** | `free -h` | High swap usage $\to$ RAM exhaustion. |
| **Disk I/O** | `iostat` / `iotop` | High `%util` or `await` time. |
| **Network** | `iftop` / `ss` | High bandwidth usage or socket leaks. |

---

### Step 14: Production Troubleshooting (The SRE Mindset)
**Objective:** Follow a systematic, evidence-based process to resolve critical incidents.

#### 🔄 The SRE Troubleshooting Workflow
1. **Alert**: Receive notification (e.g., PagerDuty).
2. **Collect Evidence**: `uptime`, `df -h`, `free -h`, `top`.
3. **Check Services**: `systemctl status <service>`.
4. **Read Logs**: `journalctl -u <service> -n 50`.
5. **Find Root Cause**: Identify *why* it happened (not just *what* happened).
6. **Fix & Verify**: Apply fix and confirm health.
7. **Post-Mortem (RCA)**: Document the incident to prevent recurrence.

---

### Step 15: Real-World DevOps Projects
**Objective:** Build a GitHub portfolio with production-grade projects.

#### 🏗️ Project Catalog
| Project | Difficulty | Skills Applied |
| :--- | :--- | :--- |
| **1. Server Hardening** | ⭐⭐ | SSH, UFW, Users, Fail2Ban |
| **2. User Automation** | ⭐⭐ | Bash Scripting, User/Group Management |
| **3. Backup System** | ⭐⭐⭐ | Tar, Cron, Bash, Storage |
| **4. Health Monitor** | ⭐⭐⭐ | `free`, `df`, `uptime`, Scripting |
| **5. Log Alerting** | ⭐⭐⭐ | `grep`, `awk`, `tail`, Bash |
| **6. Nginx Deployment** | ⭐⭐⭐⭐ | Nginx, Reverse Proxy, SSL, systemd |
| **7. SSH Bastion** | ⭐⭐⭐⭐ | Secure Tunneling, Key Management |
| **8. Multi-Service VM** | ⭐⭐⭐⭐ | systemd, Port Management, Networking |
| **9. Troubleshooting Lab**| ⭐⭐⭐⭐⭐ | Incident simulation and RCA |
| **10. Production Env** | ⭐⭐⭐⭐⭐ | Capstone: Full server lifecycle setup |

---

## 📚 Resources & Next Steps

### 🔗 Learning Links
- [Linux Journey](https://linuxjourney.com/) - Best for beginners.
- [The Linux Foundation (LFS101)](https://training.linuxfoundation.org/) - Industry standard.
- [Brendan Gregg's Blog](https://www.brendangregg.com/) - The gold standard for performance tuning.
- [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/) - Gamified CLI practice.

### 🔜 What's Next?
Once you master Linux, follow this progression:
`Git & GitHub` $\to$ `Docker` $\to$ `Kubernetes` $\to$ `Jenkins / GitHub Actions` $\to$ `Ansible` $\to$ `Terraform` $\to$ `AWS/Azure/GCP`.

---
**🎯 Final Advice:** A junior engineer memorizes commands. A professional DevOps engineer follows a process. **Don't guess—measure.**
