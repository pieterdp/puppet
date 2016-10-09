##
# Create a sudo group that can execute any command (with a password)
# Requires saz-sudo
class pp_accounts::config::sudo () inherits pp_accounts {

    class {'sudo': }

    ##
    # Create the sudo group
    group {'sudo':
        ensure => present,
    }

    ##
    # Add the sudo configuration
    sudo::conf {'sudo':
        content => '%sudo ALL=(ALL:ALL) ALL',
    }
}