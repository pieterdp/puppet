##
# Configure the pre rules for IPV6
class pp_firewall::config::pre::ipv6 () inherits pp_firewall {

    Firewall {
        require => undef,
    }

    ##
    # For INPUT and FORWARD, default DROP
    # For OUTPUT, default ACCEPT
    firewallchain {'INPUT:filter:IPv6':
        ensure   => present,
        policy   => 'drop',
        purge    => true,
    }
    firewallchain {'FORWARD:filter:IPv6':
        ensure   => present,
        policy   => 'drop',
        purge    => true,
    }
    firewallchain {'OUTPUT:filter:IPv6':
        ensure   => present,
        policy   => 'accept',
        purge    => true,
    }


    ##
    # Default rules to create a working box
    firewall { '000 ICMP (v6)':
        proto    => 'ipv6-icmp',
        action   => 'accept',
        provider => 'ip6tables',
    }
    ->
    firewall {'001 LO (v6)':
        proto    => 'all',
        iniface  => 'lo',
        action   => 'accept',
        provider => 'ip6tables',
    }
    ->
    firewall {'003 RELATED ESTABLISHED (v6)':
        proto    => 'all',
        state    => ['RELATED', 'ESTABLISHED'],
        action   => 'accept',
        provider => 'ip6tables',
    }
    ->
    firewall {'004 SSH (v6)':
        proto    => 'tcp',
        dport    => '22',
        action   => 'accept',
        chain    => 'INPUT',
        provider => 'ip6tables',
    }
}