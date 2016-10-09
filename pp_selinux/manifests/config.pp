##
# Install the SELinux configuration script
class pp_selinux::config () inherits pp_selinux {

    file {'/etc/selinux/config':
        ensure => present,
        mode   => '0644',
        source => 'puppet:///modules/pp_selinux/config',
    }
}