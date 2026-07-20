
We have 4 hours to become dangerous enough that someone can hand you a Linux server and you won't panic.

Forget 90% of tutorials.

Ignore:

Linux history.
Every command anyone calls "essential" unless you actually use it.
Memorizing 200 commands.
Fancy shell customization.
Vim vs Nano debates.
Kubernetes.
Terraform.
Jenkins.
AWS.

Those are later.

For the next four hours your world is one Ubuntu VM.

Your mission is simple:

Take a brand-new Linux server and turn it into a running web application that survives reboots.

If you can do this without Googling every step, you're ahead of a surprising number of people who mainly watched courses.

Hour 1 — Learn Linux by breaking it

Open an Ubuntu VM.

Not WSL.
Not Git Bash.

An actual Ubuntu installation.

Now pretend I hired you.

Your server is empty.

Type

pwd
ls
cd
mkdir project
cd project
touch app.txt
echo "hello" > app.txt
cat app.txt
cp app.txt backup.txt
mv backup.txt old.txt
rm old.txt

Don't memorize.

Ask yourself after every command:

What changed?

That's Linux.

Everything is manipulating files.

Now permissions.

mkdir secret
touch secret/data.txt
chmod 000 secret/data.txt
cat secret/data.txt

It fails.

Good.

Now

chmod 644 secret/data.txt

It works.

Congratulations.

You just learned more Linux than reading permission theory for three hours.

Hour 2 — Processes

Computers exist to run processes.

Everything else is decoration.

Run

sleep 500

Terminal freezes.

Open another terminal.

Find it.

ps aux

Find PID.

Kill it.

kill PID

Now run

python3 -m http.server 8000

Visit

localhost:8000

You made a web server.

Now stop it.

Now run it in background.

python3 -m http.server 8000 &

Find it.

Kill it.

Repeat until you don't need notes.

Hour 3 — The filesystem is the operating system

You now become root.

sudo -i

Explore.

cd /etc
cd /var
cd /home
cd /tmp
cd /usr

Do NOT memorize everything.

Only remember:

/etc      configuration

/var      changing data

/home     users

/tmp      temporary

/opt      optional software

/usr/bin  programs

That alone solves hundreds of future problems.

Now install software.

sudo apt update
sudo apt install nginx

Start it.

sudo systemctl start nginx

Check.

systemctl status nginx

Open browser.

See the welcome page.

Now reboot VM.

sudo reboot

Does nginx come back?

If not,

sudo systemctl enable nginx

That one command explains why some servers survive reboot and others don't.

Hour 4 — The exercise

This single exercise combines almost everything a junior DevOps engineer does.

Start with a clean VM.

Your task:

Create a new user.
sudo adduser deploy
Give them SSH access.
Install Git.
sudo apt install git
Clone any small web application.
Install nginx.
Run the application.
Configure nginx as reverse proxy.
Make application reachable.
Make application restart automatically after reboot.
Verify after reboot.

No tutorial.

Google errors.

Fix them.

Repeat from scratch tomorrow.

This one exercise teaches:

Linux
Packages
Users
Permissions
Services
Networking
Reverse proxy
Logs
Process management
Deployment

That is a large portion of day-to-day junior DevOps work.

When something breaks

Don't guess.

Use this order every single time.

Is the process running?
ps aux
Is the service running?
systemctl status SERVICE
What do the logs say?
journalctl -u SERVICE
Is the port listening?
ss -tulpn
Can I reach it locally?
curl localhost:PORT

This habit is worth more than memorizing another hundred commands.

If I could leave you with only five commands
ls
cd
cat
systemctl
journalctl

Why?

Because almost every production problem becomes:

Find the file.

Read the config.

Check the service.

Read the logs.

Your 80% exercise

If you do only one thing, do this:

Provision a fresh Ubuntu VM, deploy a simple web app behind Nginx, configure it as a systemd service, reboot the VM, and verify the app comes back automatically. Then delete the VM and repeat from scratch without following notes.

That exercise forces you to use the Linux filesystem, package management, permissions, processes, services, networking, logs, and troubleshooting in one realistic workflow. Repeating it a few times builds the kind of practical confidence that carries over to real servers far better than watching more videos or memorizing command lists.
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
First: Forget These Topics Completely (for now)

Ignore until after your interview:

Vim plugins
Shell customization (Oh My Zsh, themes)
Compiling kernels
Bash scripting beyond basics
SELinux deep internals
Linux history
Every filesystem type ever created
300 commands from cheat sheets

These make people feel productive.

Interviewers almost never care.

What You Learn First

Imagine your interviewer says:

"SSH into this server. Something is wrong. Find it."

Everything comes down to answering five questions.

1. Where am I?
pwd
ls -lah
cd
tree

Exercise

mkdir -p company/project/{logs,configs,scripts,data}
cd company/project
tree

If navigation isn't automatic, nothing else matters.

2. What is this file?
cat
less
head
tail
file
stat

Now create files.

echo "ERROR Database Down" > logs/app.log
echo "Server Started" >> logs/app.log
tail logs/app.log

Interview question:

"Last 20 log lines?"

Answer:

tail -20 app.log
3. Find things FAST

This separates beginners from professionals.

Learn:

find
grep
which
locate

Exercises

Find every log

find . -name "*.log"

Search error

grep ERROR logs/app.log

Search recursively

grep -r ERROR .

Every Linux interview asks this.

4. Permissions

This is huge.

Create a script.

touch backup.sh

Run it.

./backup.sh

Fails.

Fix.

chmod +x backup.sh

Understand:

r
w
x

Then

chmod 755
chmod 644

Nothing more.

Ignore symbolic permissions until later.

5. Processes

This is where "2 years experience" starts showing.

Run

sleep 500 &

Now investigate.

ps -ef
ps aux
top
kill
kill -9
pgrep sleep

Interview:

"Java process consuming CPU. Kill it."

You immediately know:

ps -ef | grep java
kill PID
Now Learn the Most Important Skill

Not commands.

Pipelines.

Linux isn't about commands.

It's about combining commands.

Example

Find all ERRORs.

grep ERROR app.log

Count them.

grep ERROR app.log | wc -l

Sort them.

cat app.log | sort

Unique values

sort app.log | uniq

Find biggest files

find . -type f | xargs ls -lh | sort -k5

Interviewers love seeing pipes.

Now Logs

Every production engineer lives in logs.

Create one.

for i in {1..100}
do
echo "$(date) INFO User Login" >> app.log
done

echo "ERROR Database Down" >> app.log

Now answer questions.

Last line?

tail -1 app.log

Live monitoring?

tail -f app.log

Errors only?

grep ERROR app.log

Count INFO?

grep INFO app.log | wc -l
Disk Space

Know only these.

df -h
du -sh *
free -h

Interview:

Disk full.

What do you do?

df -h
du -sh /*
find / -size +500M

Done.

Services

For systemd.

systemctl status nginx
systemctl restart nginx
systemctl stop nginx
systemctl start nginx
systemctl enable nginx

You don't need anything deeper for most interviews.

Networking

Only these.

ip addr
ip route
ping
curl
ss -tulpn
netstat

Interview:

"Application unreachable."

You check

ping
curl
ss -tulpn
Users

Know only

whoami
id
sudo
passwd
groups

Maybe

useradd
usermod

Enough.

Package Managers

Ubuntu

apt update
apt install
apt remove

RHEL

yum
dnf

Know both.

Redirection
>
>>
<
2>

Examples

ls > files.txt

grep ERROR app.log > errors.txt

command 2> error.log
Archive
tar
gzip
zip
unzip

Example

tar -czvf backup.tar.gz project/

Very common.

The ONE Exercise

If you do only ONE thing...

Become the production support engineer.

Create this environment.

linux-lab/
├── logs/
├── backup/
├── users/
├── app/
├── configs/

Inside logs

app.log
db.log
nginx.log

Fill them with

INFO
WARN
ERROR

Now pretend you're on-call.

Answer these tasks without looking up commands:

Find every log file.
Count ERROR messages.
Show last 10 lines.
Find files larger than 1 MB.
Give execute permission to every .sh file.
Compress the logs.
Find the biggest directory.
Create a new user.
Kill a running process.
Check which port is listening on 8080.
Restart nginx (or explain the command if nginx isn't installed).
Check available disk space.
Find all files modified in the last day.
Search recursively for the word password.
Redirect command output and errors into separate files.

If you can complete these smoothly, you'll outperform many candidates who have memorized dozens of commands but haven't practiced solving realistic problems.

Interview Mindset (2 Years Experience)

When you're asked, "How would you troubleshoot?", avoid jumping to a command. Think in this order:

Understand the symptom ("What exactly is failing?")
Check logs (tail, grep)
Check processes (ps, top)
Check resources (df, free)
Check network (ping, curl, ss)
Apply a fix (systemctl restart, kill a process, free disk space, correct permissions)
Verify the issue is resolved

That structured approach sounds like real operational experience.

Your 4-Hour Roadmap
Hour 1: Navigation, files, find, grep, redirection.
Hour 2: Permissions, processes, disk, memory, services.
Hour 3: Networking, packages, users, archives, pipelines.
Hour 4: Repeat the production support exercise from scratch until you can complete every task without searching.