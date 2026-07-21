#!/bin/bash

SOURCE="/home/devops_anil/Documents"
BACKUP="/home/devops_anil/backup"

mkdir -p "$BACKUP"

tar -czf "$BACKUP/backup-$(date +%F).tar.gz" "$SOURCE"

echo "Backup completed."
