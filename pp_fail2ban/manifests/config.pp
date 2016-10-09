##
# Configure fail2ban
class pp_fail2ban::config () inherits pp_fail2ban {

    ##
    # Copy configuration and jail files from files/
    File {
        ensure  => present,
        require => Package['fail2ban'],
        before  => Service['fail2ban'],
        owner   => root,
        group   => root,
    }

    ##
    # Jail configuration is in jail.d - new jails can be created
    # by adding files.
    file {'/etc/fail2ban/jail.d/ssh.conf':
        source => 'puppet:///modules/pp_fail2ban/ssh.conf',
    }

    ##
    # Debian and RedHat have different configuration files
    if $::os['family'] == 'Debian' {
        $source = 'jail.local.auto'
    } elsif $::os['family'] == 'RedHat' {
        $source = 'jail.local.systemd'
    } else {
        fail('This module can only be used on Debian or RedHat based systems.')
    }

    file {'/etc/fail2ban/jail.local':
        source => "puppet:///modules/pp_fail2ban/${source}",
    }

}