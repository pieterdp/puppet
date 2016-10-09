##
# Configure the accounts on a server
# This class sets the stage, and the defined resource
# account will be the interface
class pp_accounts (
    $create_home = $pp_accounts::params::create_home,
    $shell = $pp_accounts::params::shell,
    $purge_ssh_keys = $pp_accounts::params::purge_ssh_keys,
) inherits pp_accounts::params {

    include pp_accounts::config
}