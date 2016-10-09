##
# Enable/start the fail2ban service
class pp_fail2ban::service () inherits pp_fail2ban {

    service {'fail2ban':
        ensure => running,
        enable => true,
    }
}