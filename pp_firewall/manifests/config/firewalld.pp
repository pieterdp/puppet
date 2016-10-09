##
# Configure firewalld (RedHat-based distros)
class pp_firewall::config::firewalld () inherits pp_firewall {

    ##
    # Internal network (Digital Ocean Droplets in Amsterdam)
    # Always on interface eth1
    firewalld_zone {'amsinternal':
        ensure           => present,
        purge_rich_rules => true,
        purge_services   => true,
        purge_ports      => true,
        interfaces       => ['eth1'],
        require          => Service['firewalld'],
    }
    firewalld_rich_rule {'SSH@internal':
        ensure  => present,
        zone    => 'amsinternal',
        service => 'ssh',
        action  => 'accept',
    }

    ##
    # External network (also Amsterdam): "The Internet"
    # Always on interface eth0
    firewalld_zone {'amsexternal':
        ensure           => present,
        purge_rich_rules => true,
        purge_services   => true,
        purge_ports      => true,
        interfaces       => ['eth0'],
        require          => Service['firewalld'],
    }
    firewalld_rich_rule {'SSH@external':
        ensure  => present,
        zone    => 'amsexternal',
        service => 'ssh',
        action  => 'accept',
    }
}