##
# Install Usermin packages
class pp_webmin::install::usermin () inherits pp_webmin {

    ##
    # Install dependencies
    each (['perl', 'libnet-ssleay-perl', 'openssl', 'libauthen-pam-perl', 'libpam-runtime', 'libio-pty-perl']) | $package | {
        package {$package:
            ensure => installed,
            before => File['/root/usermin_1.701_all.deb'],
        }
    }

    ##
    # Download the package (in /root/)
    file {'/root/usermin_1.701_all.deb':
        ensure => present,
        source => 'http://prdownloads.sourceforge.net/webadmin/usermin_1.701_all.deb',
        before => Package['usermin'],
    }

    ##
    # Install Usermin
    package {'usermin':
        ensure   => installed,
        source   => '/root/usermin_1.701_all.deb',
        provider => 'dpkg',
    }
}