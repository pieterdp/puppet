##
# Configure backup scripts
class pp_backup::config::scripts () inherits pp_backup {

    ##
    # List of directories to back-up
    file {'/opt/backup/directory_list.cfg':
        ensure => present,
        owner  => 'rdiff-backup',
        group  => 'rdiff-backup',
        mode   => '0770',
        source => 'puppet///modules/pp_backup/directory_list.cfg',
    }
}