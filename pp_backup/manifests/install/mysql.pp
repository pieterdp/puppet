##
# Install the mysql backup script
class pp_backup::install::mysql () inherits pp_backup {

    File {
        owner  => 'rdiff-backup',
        group  => 'rdiff-backup',
    }

    file {'/var/backup':
        ensure => directory,
    }

    file {'/var/backup/mysql':
        ensure => directory
    }

    file {'/opt/backup/mysql_backup.sh':
        ensure => present,
        mode   => '0770',
        source => 'puppet:///modules/pp_backup/mysql_backup.sh',
    }
}