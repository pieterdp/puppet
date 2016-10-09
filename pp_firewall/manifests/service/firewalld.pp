##
# Configure firewalld (RedHat-based distros)
class pp_firewall::service::firewalld () inherits pp_firewall {

    service {'firewalld':
        ensure => running,
    }
}