##
# Cofigure the SSH server
# https://stribika.github.io/2015/01/04/secure-secure-shell.html
class pp_ssh::config::server () inherits pp_ssh {

    class {'ssh::server':
        storeconfigs_enabled => false,
        options              => {
            'Port'                            => 22,
            'UsePrivilegeSeparation'          => 'yes',
            'SyslogFacility'                  => 'AUTH',
            'LogLevel'                        => 'INFO',
            'PrintLastLog'                    => 'yes',
            'X11Forwarding'                   => 'no',
            'TCPKeepALive'                    => 'yes',
            'StrictModes'                     => 'yes',
            'IgnoreRhosts'                    => 'yes',
            'Protocol'                        => '2',
            'HostKey'                         => $pp_ssh::server_host_key,
            'KeyRegenerationInterval'         => '3600',
            'ServerKeyBits'                   => '2048',
            'KexAlgorithms'                   => $pp_ssh::server_kex_algorithms,
            'Ciphers'                         => $pp_ssh::server_ciphers,
            'MACs'                            => $pp_ssh::server_macs,
            'LoginGraceTime'                  => '60',
            'PermitRootLogin'                 => 'no',
            'PermitEmptyPasswords'            => 'no',
            'PasswordAuthentication'          => 'no',
            'ChallengeResponseAuthentication' => 'no',
            'RSAAuthentication'               => 'no',
            'PubkeyAuthentication'            => 'yes',
            'AllowUsers'                      => $pp_ssh::server_allow_users,
        }
    }

}