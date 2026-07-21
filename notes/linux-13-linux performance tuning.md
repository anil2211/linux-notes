Step 13 – Linux Performance Tuning

Goal: Learn how to monitor, analyze, and optimize Linux system performance by identifying CPU, memory, disk, and network bottlenecks.

Reality in DevOps:

Imagine it's 2:00 AM.

Your monitoring system sends an alert:

🚨 Production API response time increased from 120ms to 8 seconds.

Your manager asks:

"What is causing the server to become slow?"

You don't have time to guess.

You need to determine whether the problem is:

CPU
Memory
Disk I/O
Network
Process
Application

This is exactly what Performance Tuning is about.

🎯 Learning Objectives

By the end of this step, you'll be able to:

Understand Linux performance fundamentals
Monitor CPU usage
Analyze memory utilization
Monitor disk performance
Analyze network performance
Identify performance bottlenecks
Use industry-standard Linux monitoring tools
Troubleshoot slow production servers
1. Understanding Linux Performance

Linux performance is mainly divided into four major resources.

                 Linux Performance

                      Server
                         │
     ┌──────────┬─────────┴─────────┬──────────┐
     │          │                   │          │
    CPU      Memory             Disk I/O    Network

Whenever a server becomes slow, the problem is almost always related to one (or more) of these resources.

2. CPU Performance

The CPU executes every instruction on your system.

High CPU usage may indicate:

Infinite loops
Heavy applications
Poorly optimized code
Too many processes
High user traffic
Check CPU Information
lscpu

Example:

Architecture: x86_64
CPU(s): 4
Model name: Intel Xeon
Check Current CPU Usage
top

You'll see something like:

%Cpu(s): 25 us, 5 sy, 70 id

Meaning:

Value	Meaning
us	User CPU
sy	System CPU
id	Idle CPU
wa	Waiting for Disk
st	Steal Time (Virtual Machines)
Better Version

Install:

sudo apt install htop

Run:

htop

Advantages:

Colorful interface
Easy navigation
Kill processes
Sort by CPU
Better visualization
3. Load Average

One of the most asked interview topics.

Check:

uptime

Example:

load average: 0.45, 0.80, 1.10

These represent:

Last 1 minute
Last 5 minutes
Last 15 minutes
How to Interpret

Suppose your server has:

4 CPU Cores

Load Average:

2.00

Good.

Load:

4.00

Fully utilized.

Load:

8.00

CPU overloaded.

4. Monitor Processes

Show running processes:

ps aux

Sort by CPU:

ps aux --sort=-%cpu | head

Sort by Memory:

ps aux --sort=-%mem | head

Very common interview command.

5. Kill Misbehaving Process

Find PID:

ps aux

Kill gracefully:

kill PID

Force kill:

kill -9 PID

Use kill -9 only when necessary.

6. Memory Performance

Check RAM:

free -h

Example:

Mem:
8G total
3G used
4G free
1G cache
Important Concept

Linux uses free RAM for caching.

Seeing:

Free Memory = 500MB

does NOT necessarily mean memory is exhausted.

Always check:

Available Memory
7. Virtual Memory

Check:

vmstat

Install if needed:

sudo apt install procps

Example:

procs memory swap io system cpu

Useful columns:

r → Running processes
b → Blocked
si → Swap In
so → Swap Out

Heavy swapping usually indicates memory pressure.

8. Disk Performance

Disk I/O is often the bottleneck in databases and logging systems.

Check Disk Usage
df -h
Check Directory Sizes
du -sh /var/*
Install iostat
sudo apt install sysstat

Run:

iostat

Detailed:

iostat -x 2

Useful fields:

Field	Meaning
%util	Disk Utilization
await	Wait Time
r/s	Reads/sec
w/s	Writes/sec
9. Find Disk I/O Heavy Processes

Install:

sudo apt install iotop

Run:

sudo iotop

Shows:

Which process is reading
Which process is writing
10. Network Performance

Check interfaces:

ip a

Connections:

ss -tulpn

Check packet statistics:

netstat -i

or

ip -s link
11. Monitor Bandwidth

Install:

sudo apt install iftop

Run:

sudo iftop

Shows:

Incoming traffic
Outgoing traffic
Top bandwidth users
12. System Activity Report (sar)

Install:

sudo apt install sysstat

CPU:

sar -u 1 5

Memory:

sar -r 1 5

Disk:

sar -d 1 5

Network:

sar -n DEV 1 5
13. Check Open Files

Sometimes applications fail because too many files are open.

Check:

lsof

Count:

lsof | wc -l
14. Monitor Real-Time Logs
journalctl -f

Or

tail -f /var/log/syslog

Useful during performance troubleshooting.

15. Performance Troubleshooting Workflow

When a server becomes slow:

Step 1

CPU

top
Step 2

Memory

free -h
Step 3

Disk

df -h
Step 4

Disk I/O

iostat -x
Step 5

Network

ss -tulpn
Step 6

Logs

journalctl
Step 7

Processes

ps aux --sort=-%cpu

Never guess.

Always collect evidence first.

Practical Lab (90 Minutes)
Task 1

View CPU information.

lscpu
Task 2

Monitor CPU.

top
Task 3

Install:

sudo apt install htop

Run:

htop
Task 4

Check load average.

uptime
Task 5

View top CPU-consuming processes.

ps aux --sort=-%cpu | head
Task 6

Check memory.

free -h
Task 7

Check virtual memory.

vmstat 2 5
Task 8

Install:

sudo apt install sysstat

Run:

iostat -x
Task 9

Install:

sudo apt install iotop

Run:

sudo iotop
Task 10

Monitor bandwidth.

sudo iftop
Real DevOps Scenario
Problem

Your website has suddenly become very slow.

Users report:

"Every page takes 10–15 seconds to load."

Investigation

Check CPU:

top

CPU is only 20%.

Good.

Check Memory:

free -h

Enough RAM available.

Check Disk:

df -h

Disk is only 40% full.

Check Disk I/O:

iostat -x

Disk utilization:

99%

Found the bottleneck.

Check I/O Processes:

sudo iotop

One backup process is writing several GB every minute.

You stop or reschedule the backup.

Website latency returns to normal.

Biggest Mistakes Engineers Make
❌ Mistake 1

Looking only at CPU.

Many slow servers have low CPU usage but high Disk I/O or memory pressure.

❌ Mistake 2

Killing processes immediately.

First determine why the process is consuming resources.

❌ Mistake 3

Ignoring Load Average.

CPU utilization and Load Average are different metrics.

Understand both.

❌ Mistake 4

Ignoring logs.

Performance issues often leave clues in application and system logs.

Free Resources
Linux Journey

Read:

Processes
Performance
Monitoring
Brendan Gregg

Study his Linux Performance articles and diagrams.

The Linux Foundation

Introduction to Linux

Performance Monitoring chapters.

YouTube

freeCodeCamp Linux Course

Performance Monitoring section.

Interview Questions
What is Load Average?
What is the difference between CPU usage and Load Average?
What does top display?
What is htop?
What is swap memory?
What does free -h show?
What is Disk I/O?
What is iostat used for?
What is iotop used for?
How would you troubleshoot a slow Linux server?
Assignment

Run the following commands and understand every field:

lscpu
top
htop
uptime
free -h
vmstat 2 5
df -h
iostat -x
sudo iotop
sar -u 1 5
ps aux --sort=-%cpu | head

Create a Performance Report containing:

CPU Information
Load Average
Memory Usage
Swap Usage
Disk Usage
Top 5 CPU Processes
Top 5 Memory Processes
Disk I/O Statistics
Network Status
Your analysis of whether the system is healthy
🎯 Mentor's Advice

Professional DevOps engineers don't guess—they measure.

Whenever you face a performance issue, use this checklist:

CPU → top, htop, lscpu
Load → uptime
Memory → free -h, vmstat
Disk Space → df -h
Disk I/O → iostat, iotop
Network → ss, iftop
Processes → ps aux
Logs → journalctl

Following this sequence will help you identify bottlenecks quickly and confidently during production incidents and technical interviews.

📌 What's Next?

Step 14 – Production Troubleshooting (Think Like an SRE)

You'll learn:

A systematic troubleshooting methodology
Real production incidents
Root Cause Analysis (RCA)
Incident response
Log correlation
Service dependency troubleshooting
Production debugging scenarios asked in DevOps interviews

This is where you'll transition from knowing Linux commands to solving real-world production problems like an experienced DevOps Engineer.