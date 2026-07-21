#!/bin/bash

URL="https://example.com"

STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

if [ "$STATUS" -eq 200 ]
then
    echo "Website is UP"
else
    echo "Website is DOWN (HTTP $STATUS)"
fi
