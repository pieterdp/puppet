##
# Configure the firewall for a specific role
class pp_firewall () inherits pp_firewall::params {

    if $::os['family'] == 'Debian' {
        resources {'firewall':
            purge => true,
        }

        resources {'firewallchain':
            purge => true,
        }
    }

    include pp_firewall::config
}