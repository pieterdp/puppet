##
# Configure the firewall. Uses pp_firewall to lay the groundwork
# Supports ports 80 (HTTP) and 443 (HTTPS)
class pp_apache::config::firewall () inherits pp_apache {

    include pp_firewall

    Firewall {
        require => Class['pp_firewall::config::pre']
    }

    firewall {'201 HTTP':
        proto  => 'tcp',
        dport  => '80',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'202 HTTPS':
        proto  => 'tcp',
        dport  => '443',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'201 HTTP (v6)':
        proto    => 'tcp',
        dport    => '80',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }

    firewall {'202 HTTPS (v6)':
        proto    => 'tcp',
        dport    => '443',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }
}