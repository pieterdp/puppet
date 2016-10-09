##
# Configure the automatic update policy
# Requires puppetlabs-apt
class pp_upgrades () {

    if $::os['family'] == 'Debian' {
        include pp_upgrades::install::apt
        include pp_upgrades::config::apt
    } elsif $::os['family'] == 'RedHat' {
        include pp_upgrades::install::yum
        include pp_upgrades::config::yum
    } else {
        fail('Only Debian and RedHat-based systems are supported.')
    }
}