##
# Configure the backup service
class pp_backup::service () inherits pp_backup {

    ##
    # Create a cron job to run the daily back-up
    cron {'backup_daily':
        command => '/opt/backup/run_script',
        user    => 'rdiff-backup',
        hour    => 1,
        minute  => 0,
    }

    ##
    # Create a cron job for mysql back-ups
    # Note that they have to run before backup_daily or backup-daily will back-up
    # an older version of the mysql dump
    if $pp_backup::enable_mysql_backup == true {
        cron {'backup_mysql':
            command => '/opt/backup/mysql_backup.sh',
            user    => 'rdiff-backup',
            hour    => 0,
            minute  => 15,
        }
    }
}