##
# Install the unattended upgrade package
class pp_upgrades::install::apt () inherits pp_upgrades {

    package {'unattended-upgrades':
        ensure => installed,
    }
}