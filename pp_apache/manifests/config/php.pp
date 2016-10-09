##
# Configure PHP for websites that use it (in combination with Apache)
class pp_apache::config::php () inherits pp_apache {

    if $::os['family'] != 'Debian' {
        fail('Installing PHP packages is only supported on Debian-based systems.')
    }

    each(['php5', 'php5-curl', 'php5-mysql', 'libapache2-mod-php5']) | $package | {
        package {$package:
            ensure => installed,
        }

    }

    include apache::mod::php

    ##
    # Most applications use Composer. Install it system-wide.
    file {'/opt/composer':
        ensure => directory,
    }

    # This installs v1.2.1 - will have to be manually updated here
    file {'/opt/composer/composer.phar':
        ensure => present,
        source => 'https://getcomposer.org/download/1.2.1/composer.phar',
    }
}