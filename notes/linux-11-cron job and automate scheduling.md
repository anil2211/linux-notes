Step 11 – Cron Jobs & Task Scheduling

Goal: Learn how to automatically run commands and scripts at specific times without manual intervention.

Reality in DevOps:

Imagine you are managing 200 Linux servers.

Every day you need to:

Take backups
Check disk usage
Clean temporary files
Rotate logs
Generate reports
Restart specific services

Would you log into every server manually?

Absolutely not.

This is where Cron comes in.

Cron is one of the oldest and most reliable automation tools in Linux.

🎯 Learning Objectives

By the end of this step, you'll be able to:

Understand Cron and Crontab
Schedule scripts automatically
Understand Cron expressions
Redirect output to log files
Schedule backups and monitoring scripts
Troubleshoot Cron jobs
Build production-ready scheduled tasks
1. What is Cron?

Cron is a job scheduler.

It executes commands automatically according to a schedule.

Example:

Instead of running

backup.sh

every night yourself,

Cron runs it automatically at 2:00 AM.

Think of Cron as Linux's alarm clock.

2. How Cron Works
Your Script
      │
      ▼
   Crontab
      │
      ▼
 Cron Daemon
      │
      ▼
 Executes Automatically

The Cron daemon continuously checks whether any scheduled job should run.

3. Check Whether Cron is Running

Ubuntu:

systemctl status cron

RHEL/CentOS:

systemctl status crond

If stopped:

sudo systemctl start cron

Enable during boot:

sudo systemctl enable cron
4. Crontab

Every user has their own schedule file called Crontab.

Open it:

crontab -e

View existing jobs:

crontab -l

Delete all jobs:

crontab -r

Be careful:

crontab -r

removes every scheduled job.

5. Cron Job Format

Every cron job has five timing fields followed by the command.

* * * * * command

│ │ │ │ │
│ │ │ │ └── Day of Week (0–7)
│ │ │ └──── Month
│ │ └────── Day of Month
│ └──────── Hour
└────────── Minute
6. Understanding Each Field

Run every minute:

* * * * *

Run every hour:

0 * * * *

Run every day at midnight:

0 0 * * *

Run every Sunday:

0 2 * * 0

Run every Monday at 9 AM:

0 9 * * 1
7. Special Characters
Character	Meaning
*	Every value
,	Multiple values
-	Range
/	Step value

Examples:

Every five minutes:

*/5 * * * *

Every ten minutes:

*/10 * * * *

Every weekday:

0 9 * * 1-5
8. Schedule Your First Script

Create:

nano hello.sh
#!/bin/bash

echo "Cron executed at $(date)" >> ~/cron.log

Make executable:

chmod +x hello.sh

Open crontab:

crontab -e

Add:

* * * * * /home/YOUR_USERNAME/hello.sh

Wait one minute.

Verify:

cat ~/cron.log
9. Redirect Output

Never ignore script output.

Instead of:

0 2 * * * backup.sh

Use:

0 2 * * * /home/anil/backup.sh >> /home/anil/backup.log 2>&1

Meaning:

Standard output → backup.log
Errors → backup.log
10. Always Use Absolute Paths

Bad:

backup.sh

Good:

/home/anil/backup.sh

Cron has a limited environment.

Always use complete paths.

11. Useful DevOps Cron Jobs

Daily backup:

0 1 * * * /home/anil/backup.sh

Health check every 5 minutes:

*/5 * * * * /home/anil/health_check.sh

Disk usage report every six hours:

0 */6 * * * /home/anil/disk_report.sh

Delete temporary files weekly:

0 0 * * 0 find /tmp -type f -mtime +7 -delete
12. Cron Logs

Ubuntu:

grep CRON /var/log/syslog

or

journalctl -u cron

Always check logs before assuming Cron isn't working.

13. Environment Variables

Cron doesn't load your normal shell environment.

If needed:

PATH=/usr/local/bin:/usr/bin:/bin

Use absolute paths whenever possible.

14. Common Cron Problems

Script doesn't execute.

Check:

Execute permission
chmod +x script.sh
Correct path
Cron service
Log files
15. Production Best Practices

✔ Use absolute paths.

✔ Log every Cron job.

✔ Test scripts manually first.

✔ Schedule heavy jobs during off-peak hours.

✔ Keep Cron jobs small and focused.

Practical Lab (45–60 Minutes)
Task 1

Check Cron service.

systemctl status cron
Task 2

Open Crontab.

crontab -e
Task 3

List scheduled jobs.

crontab -l
Task 4

Create:

hello.sh

Schedule it every minute.

Verify the output.

Task 5

Create a backup script.

Schedule it daily at 2 AM.

Task 6

Create a health check script.

Run it every five minutes.

Task 7

Redirect output to a log file.

Verify logs.

Task 8

View Cron logs.

journalctl -u cron
Real DevOps Scenario

Suppose your company requires:

Backup every day at 1 AM
Health check every 5 minutes
Cleanup every Sunday
Disk usage report every six hours

You would configure:

0 1 * * * backup.sh

*/5 * * * * health_check.sh

0 */6 * * * disk_report.sh

0 0 * * 0 cleanup.sh

No manual work is required.

Biggest Mistakes Engineers Make
❌ Mistake 1

Using relative paths.

Always use:

/home/anil/script.sh
❌ Mistake 2

Not checking Cron logs.

Always verify:

journalctl -u cron
❌ Mistake 3

Forgetting execute permission.

chmod +x script.sh
❌ Mistake 4

Not redirecting output.

Without logs, debugging becomes much harder.

Free Resources
Linux Journey

Study the Scheduling Tasks section.

The Linux Foundation

Introduction to Linux

Read the chapter on Cron and scheduled tasks.

YouTube

freeCodeCamp Linux Course

Watch the sections on Cron and automation.

Interview Questions
What is Cron?
What is Crontab?
Explain the five fields of a Cron expression.
What does */5 * * * * mean?
How do you list Cron jobs?
How do you edit Cron jobs?
Why should you use absolute paths in Cron?
How do you check whether Cron is running?
Where are Cron logs stored?
How would you troubleshoot a Cron job that isn't executing?
Assignment

Create and test:

hello.sh
backup.sh
health_check.sh
cleanup.sh

Schedule them as follows:

Every minute
Daily at 2 AM
Every 5 minutes
Every Sunday

Verify that:

Cron executed successfully.
Log files were created.
The scheduled times are correct.
🎯 Mentor's Advice

Cron is one of the simplest yet most powerful Linux automation tools.

A junior engineer runs maintenance tasks manually.

A DevOps engineer schedules them once and lets Linux handle the rest.

Always remember this workflow:

Write the script.
Test it manually.
Make it executable.
Schedule it with Cron.
Redirect output to logs.
Verify it works.

This disciplined approach is used in real production environments and is expected in DevOps interviews.

📌 What's Next?

Step 12: Linux Package Management

You'll learn:

APT, DPKG, YUM, and DNF
Installing, updating, and removing packages
Managing repositories
Verifying installed software
Package troubleshooting
Best practices for maintaining Linux systems

This is another essential skill for managing production servers and automating infrastructure.