#!/bin/bash

read -p "Enter service name: " service

if systemctl is-active --quiet "$service"; then
    echo "$service is running."
else
    echo "$service is not running."
fi
