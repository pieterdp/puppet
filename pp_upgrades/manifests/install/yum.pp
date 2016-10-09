##
# Install yum-cron and epel-release
class pp_upgrades::install::yum () inherits pp_upgrades {

    package {'yum-cron':
        ensure => installed,
    }

    package {'epel-release':
        ensure => installed,
    }
}