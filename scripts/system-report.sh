#!/bin/bash

echo "========== SYSTEM REPORT =========="
echo

echo "Hostname:"
hostname

echo
echo "Current User:"
whoami

echo
echo "Current Date:"
date

echo
echo "Kernel Version:"
uname -r

echo
echo "System Uptime:"
uptime

echo
echo "Memory Usage:"
free -h

echo
echo "Disk Usage:"
df -h

echo
echo "CPU Information:"
lscpu | grep "Model name"

echo
echo "==================================="
