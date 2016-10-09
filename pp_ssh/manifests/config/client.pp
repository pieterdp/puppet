##
# Configure the SSH client (with saz-ssh)
# https://stribika.github.io/2015/01/04/secure-secure-shell.html
class pp_ssh::config::client () inherits pp_ssh {

    class {'ssh::client':
        storeconfigs_enabled => false,
        options              => {
            'Host *' => {
                'UseRoaming'                      => 'no',
                'ForwardAgent'                    => 'no',
                'ForwardX11'                      => 'no',
                'FallBackToRsh'                   => 'no',
                'UseRsh'                          => 'no',
                'CheckHostIP'                     => 'yes',
                'PasswordAuthentication'          => 'no',
                'ChallengeResponseAuthentication' => 'no',
                'RhostsAuthentication'            => 'no',
                'RhostsRSAAuthentication'         => 'no',
                'RSAAuthentication'               => 'no',
                'PubkeyAuthentication'            => 'yes',
                'KexAlgorithms'                   => $pp_ssh::client_kex_algorithms,
                'Ciphers'                         => $pp_ssh::client_ciphers,
                'MACs'                            => $pp_ssh::client_macs,
            }
        }
    }

}