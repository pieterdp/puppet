##
# Configure the firewall
# tcp 445 139
# udp 137 138
class pp_smb::config::firewall () inherits pp_smb {

    include pp_firewall

    Firewall {
        require => Class['pp_firewall::config::pre']
    }

    firewall {'203 SAMBA':
        proto  => 'tcp',
        dport  => '445',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'204 SAMBA':
        proto  => 'tcp',
        dport  => '139',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'205 SAMBA':
        proto  => 'udp',
        dport  => '137',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'206 SAMBA':
        proto  => 'udp',
        dport  => '138',
        action => 'accept',
        chain  => 'INPUT',
    }

    firewall {'203 SAMBA (v6)':
        proto    => 'tcp',
        dport    => '445',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }

    firewall {'204 SAMBA (v6)':
        proto    => 'tcp',
        dport    => '139',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }

    firewall {'205 SAMBA (v6)':
        proto    => 'udp',
        dport    => '137',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }

    firewall {'206 SAMBA (v6)':
        proto    => 'udp',
        dport    => '138',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }
}