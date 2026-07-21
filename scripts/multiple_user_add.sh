#!/bin/bash

for user in dev1 dev2 dev3
do
    sudo useradd "$user"
    echo "$user created"
done
