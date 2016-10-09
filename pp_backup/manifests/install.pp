##
# Install all backup-related technologies
class pp_backup::install () inherits pp_backup {

    file {'/opt/backup':
        ensure => directory,
        owner  => 'rdiff-backup',
        group  => 'rdiff-backup',
        mode   => '0770',
    }

    file {'/opt/backup/log':
        ensure => directory,
        owner  => 'rdiff-backup',
        group  => 'rdiff-backup',
        mode   => '0770',
    }

    include pp_backup::install::rdiff
    include pp_backup::install::scripts

    if $pp_backup::enable_mysql_backup == true {
        include pp_backup::install::mysql
    }
}