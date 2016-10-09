##
# Configure yum unattended upgrades
class pp_upgrades::config::yum () inherits pp_upgrades {

    file {'/etc/yum/yum-cron.conf':
        ensure  => present,
        require => Package['yum-cron'],
        source  => 'puppet:///modules/pp_upgrades/yum-cron.conf',
    }
}