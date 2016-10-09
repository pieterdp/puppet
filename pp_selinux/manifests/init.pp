##
# Configure SELinux for RedHat-based devices (note that this class only installs the packages
# and switches selinux to targeted)
class pp_selinux () inherits pp_selinux::params {

    if $::os['family'] == 'RedHat' {
        $packages = $pp_selinux::params::packages_redhat
    } elsif $::os['family'] == 'Debian' {
        warning("Warning. I will install debian packages, but I can't guarantee everything will work.")
        $packages = $pp_selinux::params::packages_debian
    }

    include pp_selinux::install
    include pp_selinux::config
}