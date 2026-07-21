#!/bin/bash

SERVICES=("ssh" "nginx")

for SERVICE in "${SERVICES[@]}"
do
    if systemctl is-active --quiet "$SERVICE"
    then
        echo "$SERVICE : Running"
    else
        echo "$SERVICE : Stopped"
    fi
done
