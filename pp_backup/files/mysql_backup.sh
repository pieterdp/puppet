#!/bin/bash

backup_dir="/var/backup/mysql"
user="mysqldump"
password="password"
host="localhost"

if [ ! -d "$backup_dir""/latest" ]; then
	mkdir -p "$backup_dir""/latest"
fi

##
# Check if installed
which mysql > /dev/null
if [ $? -ne 0 ]; then
	# Not installed
	exit 0
fi

date=$(date -I)


mysqldump --all-databases --user="$user" --password="$password" --host="$host" | gzip > "$backup_dir""/db.sql.gz"

##
# Copy to latest for backup
cp "$backup_dir""/db.sql.gz" "$backup_dir""/latest/latest.sql.gz"
exit 0
