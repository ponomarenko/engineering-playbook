#!/bin/bash

BACKUP_DIR="/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
DB_NAME="myapp"

mkdir -p "$BACKUP_DIR"

pg_dump $DB_NAME | gzip > "$BACKUP_DIR/backup_$DATE.sql.gz"

echo "Backup completed: $BACKUP_DIR/backup_$DATE.sql.gz"

find "$BACKUP_DIR" -name "backup_*.sql.gz" -mtime +7 -delete
