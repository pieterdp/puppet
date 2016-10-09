##
# Configure the Apache server
class pp_apache (
    $ssl_cipher = $pp_apache::params::ssl_cipher,
    $ssl_protocol = $pp_apache::params::ssl_protocol,
    $default_mods = $pp_apache::params::default_mods,
    $server_admin = $pp_apache::params::server_admin,
) inherits pp_apache::params {

    include pp_apache::install
    include pp_apache::config
}