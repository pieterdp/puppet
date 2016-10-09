##
# Install rdiff-backup
class pp_backup::install::rdiff () inherits pp_backup {
    package {'rdiff-backup':
        ensure => installed,
    }
}