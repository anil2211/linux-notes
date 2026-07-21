#!/bin/bash

echo "===== SERVER HEALTH CHECK ====="

echo
echo "Hostname"
hostname

echo
echo "Uptime"
uptime

echo
echo "Disk Usage"
df -h

echo
echo "Memory"
free -h

echo
echo "CPU Load"
top -bn1 | head -5

echo
echo "Logged-in Users"
who

echo
echo "================================"
