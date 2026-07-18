🎯 Learning Objective

By the end of this step, you'll be able to:

Understand what a process is.
View running processes.
Monitor CPU and memory usage.
Start, stop, and kill processes.
Run jobs in the background.
Find process IDs (PIDs).
Troubleshoot stuck applications.
1. What is a Process?

A process is simply a program that is currently running.

For example:

Opening Chrome → Creates multiple processes.
Running python app.py → Creates one Python process.
Starting Nginx → Creates Nginx processes.

Think of it like this:

Program (stored on disk)
        │
        ▼
Running
        │
        ▼
Process

Every process has a unique PID (Process ID).

2. View Running Processes
Method 1: ps
ps

Shows processes running in your current terminal.

View All Processes
ps -ef

Example:

UID      PID   PPID  CMD
root       1      0  systemd
root     832      1  sshd
anil    2350   2200  bash
anil    2456   2350  ps

Important columns:

Column	Meaning
UID	Process owner
PID	Process ID
PPID	Parent Process ID
CMD	Command
3. Monitor Processes Live

Use:

top

This updates continuously.

You'll see:

CPU usage
Memory usage
Running processes
Load average

Press:

q

to quit.

Better Alternative

Install:

sudo apt install htop

Run:

htop

Advantages:

Easier to read
Colorful interface
Search processes
Kill processes interactively
4. Find a Specific Process

Example:

ps -ef | grep ssh

Or:

pgrep ssh

Example:

812
5. Start a Background Process

Example:

sleep 300 &

The & sends it to the background.

Output:

[1] 2481

2481 is the PID.

6. View Background Jobs
jobs

Example:

[1]+ Running sleep 300 &
7. Bring a Job Back

Foreground:

fg %1

Background again:

Press:

CTRL + Z

Then:

bg
8. Find Process ID
pidof bash

or

pgrep bash
9. Kill a Process

Suppose PID is:

2450

Kill it:

kill 2450
Force Kill

If it refuses to stop:

kill -9 2450

⚠️ Use kill -9 only when necessary because it doesn't allow the process to clean up before exiting.

10. Kill by Name

Instead of PID:

pkill sleep

or

killall sleep
11. Check CPU Usage
top

or

htop
12. Check Memory
free -h

Example:

total used free
7.6G 2.4G 4.1G
13. Check System Uptime
uptime

Example:

14:15 up 3 days,
14. View Process Tree

Install if needed:

sudo apt install psmisc

Then:

pstree

Example:

systemd
 ├── sshd
 ├── cron
 ├── nginx
 └── bash
      └── python

This helps you understand parent-child relationships.

15. Useful Commands to Remember
Command	Purpose
ps -ef	List all processes
top	Live process monitoring
htop	Interactive process viewer
jobs	Show background jobs
bg	Resume a job in background
fg	Bring a job to foreground
kill	Stop a process by PID
kill -9	Force stop a process
pkill	Stop by process name
pgrep	Find PID by process name
free -h	Show memory usage
uptime	Show system uptime
pstree	Show process hierarchy
🧪 Practical Lab (45 Minutes)
Task 1

Run:

sleep 500 &

Check:

jobs
Task 2

Find its PID:

ps -ef | grep sleep
Task 3

Kill it:

kill <PID>
Task 4

Start another one:

sleep 1000 &

Terminate it by name:

pkill sleep
Task 5

Open:

top

Observe:

CPU%
Memory
PID
Running processes

Exit with q.

Task 6

Install and run:

sudo apt install htop
htop

Spend 10 minutes exploring the interface.

Task 7

Check:

free -h
uptime
pstree

Understand the output rather than memorizing it.

🚨 Biggest Mistakes Engineers Make
❌ Mistake 1

Using:

kill -9

for every issue.

Better: Try a normal kill first. Only use kill -9 if the process doesn't terminate gracefully.

❌ Mistake 2

Killing the wrong process because the PID wasn't verified.

Always confirm:

ps -fp <PID>

before terminating an important process.

❌ Mistake 3

Ignoring high CPU or memory usage.

Before restarting services, investigate which process is consuming resources and why.

🌍 Free Learning Resources
Linux Journey → Process Management section.
The Linux Foundation – Introduction to Linux (free).
freeCodeCamp Linux Full Course (YouTube).

Practice the commands yourself on your lab machine.

💼 DevOps Real-World Scenario

Imagine your production website becomes slow.

A typical troubleshooting sequence might be:

top

➡️ Notice a Java process using 100% CPU.

ps -fp <PID>

➡️ Identify the exact process.

kill <PID>

➡️ Stop it gracefully if appropriate.

systemctl restart <service>

➡️ Restart the affected service (you'll learn systemctl in a later step).

This kind of workflow is part of day-to-day DevOps operations.

🎤 Interview Questions
What is a Linux process?
A process is a running instance of a program. It has its own memory space, process ID (PID), registers, and system resources. Every command you execute creates one or more processes.

What is a PID?
A PID (Process ID) is a unique number assigned by the Linux kernel to each running process. It is used to identify and manage processes.


What is the difference between ps and top?
ps	                                       top
Shows a snapshot of running processes.	Shows real-time process information.
Output is static.	                    Output updates continuously.
Useful for scripting.	                Useful for live monitoring and troubleshooting.
ps -ef                                        top


What is the difference between kill and kill -9?
kill PID
Sends SIGTERM (15).
Requests the process to terminate gracefully.
Allows cleanup before exiting.

kill -9 PID
Sends SIGKILL (9).
Immediately stops the process.
Cannot be caught or ignored by the process.

What is the purpose of jobs?
The jobs command lists the jobs running in the current shell, including background and stopped jobs.
jobs
[1]+ Running  sleep 100 &


What is pgrep used for?
pgrep searches for running processes by name or other attributes and returns their PIDs.
pgrep ssh



How do you move a process to the background?
Suspend the running process:
ctrl z

Resume it in the background:
bg

Or start it directly in the background:
command &


How do you bring a background job to the foreground?
Use:
fg
To bring a specific job:
fg %1

How do you monitor memory usage in Linux?
Common commands:
free -h
Shows RAM and swap usage.

top
Displays live memory usage.

htop
Interactive process and memory monitor (if installed).

vmstat
Shows virtual memory statistics.

cat /proc/meminfo
Displays detailed memory information.

What does pstree show?
pstree displays running processes in a tree (hierarchical) format, showing parent-child relationships between processes.
Example:
pstree
Sample output:

systemd
├── NetworkManager
├── sshd──bash──vim
└── cron
This helps visualize how processes are related.

📝 Today's Assignment

Complete the practical lab and send me the output of:

jobs
ps -ef | grep sleep
free -h
uptime
pstree

Quick Interview Revision
Process: Running instance of a program.
PID: Unique Process ID.
ps: Static process snapshot.
top: Live process monitoring.
kill: Graceful termination (SIGTERM).
kill -9: Forceful termination (SIGKILL).
jobs: Lists background/stopped shell jobs.
pgrep: Finds process IDs by name.
bg: Sends a stopped job to the background.
fg: Brings a background job to the foreground.
Memory monitoring: free -h, top, htop, vmstat, /proc/meminfo.
pstree: Shows the process hierarchy in a tree structure.

Then answer the 10 interview questions in your own words.