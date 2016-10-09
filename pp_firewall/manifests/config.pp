##
# Default firewall configuration
class pp_firewall::config () inherits pp_firewall {

    if $::os['family'] == 'Debian' {
        class {'firewall': }

        include pp_firewall::config::pre
    } elsif $::os['family'] == 'RedHat' {

        include pp_firewall::service::firewalld
        include pp_firewall::config::firewalld
    }
}