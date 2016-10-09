#!/bin/bash
##
# Script to execute a backup with rdiff-backup
# Designed to run daily
# Sends e-mail with log file
#if [ $(id -u) != "1003" ]; then
#       echo "Error: this script must be run as the rdiff-backup user!"
#       exit 1
#fi

source /opt/backup/directory_list.cfg
server=$(hostname -f)
dest_prefix="/backup/server/$server"
dest_ip="127.0.0.1"
##
# Create remote dir
ssh -i /home/rdiff-backup/.ssh/id_rsa "rdiff-backup@$dest_ip" "mkdir -p $dest_prefix"

for source in "${backup_dir[@]}"; do
	if [ ! -d "$source"  -a ! -f "$source" ]; then
		continue
	fi
        source_name=$(echo $source | sed 's:/:_:g')
	source_dir=$(dirname "$source")
	##
	# Backup destination = dest_prefix + source (full path) OR path/to/file
	backup_dest="$dest_prefix""/""$source""/"
	##
	# .sql files do not have to be created
	ssh -i /home/rdiff-backup/.ssh/id_rsa "rdiff-backup@$dest_ip" "mkdir -p $dest_prefix/$source"
        logfile="/opt/backup/log/log.""$source_name""."$(date -I)
        touch "$logfile"
	##
	# Delete older increments
        rdiff-backup -v0 --print-statistics --remove-older-than 6M --remote-schema 'ssh -i /home/rdiff-backup/.ssh/id_rsa -C %s "sudo /usr/bin/rdiff-backup --server"' "rdiff-backup@$dest_ip::""$backup_dest" >> "$logfile"
	##
	# Execute backup
        rdiff-backup -v0 --print-statistics --exclude-special-files --remote-schema 'ssh -i /home/rdiff-backup/.ssh/id_rsa -C %s "sudo /usr/bin/rdiff-backup --server"' "$source" "rdiff-backup@$dest_ip::""$backup_dest" >> "$logfile"
done
##

exit 0
