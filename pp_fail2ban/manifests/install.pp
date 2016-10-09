##
# Install fail2ban
class pp_fail2ban::install () inherits pp_fail2ban {

    package {'fail2ban':
        ensure => installed,
    }
}