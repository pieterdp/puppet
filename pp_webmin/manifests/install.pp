##
# Install Webmin packages
class pp_webmin::install () inherits pp_webmin {

    include apt

    ##
    # Install dependencies
    each (['libapt-pkg-perl', 'apt-show-versions']) | $package | {
        package {$package:
            ensure => installed,
            before => Package['webmin'],
        }
    }

    ##
    # Add webmin repository
    apt::source {'webmin':
        location => 'http://download.webmin.com/download/repository',
        release  => 'sarge',
        repos    => 'contrib',
    }

    ##
    # Add webmin key
    apt::key {'webmin':
        source => 'http://www.webmin.com/jcameron-key.asc',
        id     => '1719003ACE3E5A41E2DE70DFD97A3AE911F63C51',
    }

    ##
    # Add webmin
    package {'webmin':
        ensure  => installed,
        require => [Apt::Source['webmin'], Apt::Key['webmin'], Exec['apt_update']],
    }
}