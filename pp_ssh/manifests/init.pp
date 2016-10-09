##
# Configure both the SSH server and the SSH client
# Requires saz-ssh
class pp_ssh (
    $client_kex_algorithms = $pp_ssh::params::client_kex_algorithms,
    $client_ciphers = $pp_ssh::params::client_ciphers,
    $client_macs = $pp_ssh::params::client_macs,
    $server_host_key = $pp_ssh::params::server_host_key,
    $server_kex_algorithms = $pp_ssh::params::server_kex_algorithms,
    $server_ciphers = $pp_ssh::params::server_ciphers,
    $server_macs = $pp_ssh::params::server_macs,
    $server_allow_users = $pp_ssh::params::server_allow_users,
) inherits pp_ssh::params {

    if $server_allow_users == undef {
        fail('The parameter server_allow_users is required.')
    } else {
        validate_array($server_allow_users)
    }

    include pp_ssh::config

}