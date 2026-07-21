#!/bin/bash

find /var/log -type f -name "*.log" -mtime +7 -delete

echo "Old log files deleted."
