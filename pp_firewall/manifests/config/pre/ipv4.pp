##
# Configure the pre rules for IPV4
class pp_firewall::config::pre::ipv4 () inherits pp_firewall {

    Firewall {
        require => undef,
    }

    ##
    # For INPUT and FORWARD, default DROP
    # For OUTPUT, default ACCEPT
    firewallchain {'INPUT:filter:IPv4':
        ensure => present,
        policy => 'drop',
        purge  => true,
    }
    firewallchain {'FORWARD:filter:IPv4':
        ensure => present,
        policy => 'drop',
        purge  => true,
    }
    firewallchain {'OUTPUT:filter:IPv4':
        ensure => present,
        policy => 'accept',
        purge  => true,
    }


    ##
    # Default rules to create a working box
    firewall { '000 ICMP':
        proto  => 'icmp',
        action => 'accept',
        chain  => 'INPUT',
    }
    ->
    firewall {'001 LO':
        proto   => 'all',
        iniface => 'lo',
        action  => 'accept',
        chain   => 'INPUT',
    }
    ->
    firewall {'002 LO REJECT':
        proto       => 'all',
        iniface     => '! lo',
        destination => '127.0.0.1/8',
        action      => 'reject',
        chain       => 'INPUT',
    }
    ->
    firewall {'003 RELATED ESTABLISHED':
        proto  => 'all',
        state  => ['RELATED', 'ESTABLISHED'],
        action => 'accept',
        chain  => 'INPUT',
    }
    ->
    firewall {'004 SSH':
        proto  => 'tcp',
        dport  => '22',
        action => 'accept',
        chain  => 'INPUT',
    }
}