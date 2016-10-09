##
# Install selinux packages
class pp_selinux::install () inherits pp_selinux {

    each($pp_selinux::packages) | $package | {
        package {$package:
            ensure => installed,
            before => File['/etc/selinux/config'],
        }
    }
}