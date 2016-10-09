##
# Install backup scripts
class pp_backup::install::scripts () inherits pp_backup {

    File {
        ensure => present,
        owner  => 'rdiff-backup',
        group  => 'rdiff-backup',
        mode   => '0770',
    }

    each(['external_backup.sh', 'mysql_backup.sh', 'run_script']) | $script | {
        file {"/opt/backup/${script}":
            source => "puppet:///modules/pp_backup/${script}",
        }
    }
}