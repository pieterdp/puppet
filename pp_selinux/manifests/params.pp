##
# Default parameters
class pp_selinux::params {
    $packages_debian = ['selinux-basics' 'selinux-policy-default' 'auditd']
    $packages_redhat = ['policycoreutils', 'policycoreutils-python',
    'selinux-policy', 'selinux-policy-targeted', 'libselinux-utils',
    'setroubleshoot-server', 'setools', 'setools-console', 'mcstrans']
}