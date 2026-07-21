#!/bin/bash

THRESHOLD=80

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]
then
    echo "Warning: Disk usage is ${USAGE}%"
else
    echo "Disk usage is normal: ${USAGE}%"
fi
