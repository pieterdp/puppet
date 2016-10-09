##
# Configure all users
define pp_accounts::config::user (
    $account_data = undef,
    $shell = $pp_accounts::shell,
    $purge_ssh_keys = $pp_accounts::purge_ssh_keys,
    $create_home = $pp_accounts::create_home,
) {

    if ! defined(Class['pp_accounts']) {
        fail('You must include/define pp_accounts before using pp_accounts::account')
    }

    validate_array($account_data)

    ##
    # Create all users in $::account_data
    each ($account_data) | $account | {

        ##
        # Create the primary group if they aren't already defined
        if ! defined($account['primary_group']) {
            group {$account['primary_group']:
                ensure => present,
                before => User[$account['user_name']],
            }
        }

        ##
        # Create secundary groups if they aren't already defined
        each ($account['groups']) | $group | {
            if ! defined($group) {
                group {$group:
                    ensure => present,
                    before => User[$account['user_name']]
                }
            }
        }

        ##
        # Create the user (note that the home directory)
        # must be created afterwards, as it can only have the correct
        # owner after the user has been created
        $user_params = {
            'name'           => $account['user_name'],
            'gid'            => $account['primary_group'],
            'groups'         => $account['groups'],
            'shell'          => $shell,
            'home'           => "/home/${account['user_name']}",
            'purge_ssh_keys' => $purge_ssh_keys,
        }

        if $account['password'] != undef {
            user { $user_params['name']:
                *        => $user_params,
                password => $account['password'],
            }
        } else {
            user { $user_params['name']:
                * => $user_params
            }
        }

        ##
        # Create the home directory (if required)
        if $create_home == true {
            file {"/home/${account['user_name']}":
                ensure  => directory,
                mode    => '0750',
                owner   => $account['user_name'],
                group   => $account['primary_group'],
                require => User[$account['user_name']],
            }
        }

        ##
        # Create the .ssh directory to store SSH keys
        file {"/home/${account['user_name']}/.ssh":
            ensure => directory,
            mode   => '0700',
            owner  => $account['user_name'],
            group  => $account['primary_group'],
        }

        ##
        # Authorized keys
        each ($account['authorized_keys']) | $authorized_key | {
            validate_hash($authorized_key)

            if ! has_key($authorized_key, 'id') {
                fail('The key id is required in authorized_key')
            }
            if ! has_key($authorized_key, 'type') {
                fail('The key type is required in authorized_key')
            }
            if ! has_key($authorized_key, 'key') {
                fail('The key key is required in authorized_key')
            }

            ssh_authorized_key {$authorized_key['id']:
                user    => $account['user_name'],
                type    => $authorized_key['type'],
                key     => $authorized_key['key'],
                require => File["/home/${account['user_name']}/.ssh"],
            }
        }

        ##
        # Private/public key pairs
        each ($account['ssh_keys']) | $ssh_key | {
            validate_hash($ssh_key)

            if ! has_key($ssh_key, 'name') {
                fail('The key name is required in ssh_key')
            }
            if ! has_key($ssh_key, 'private') {
                fail('The key private is required in ssh_key')
            }
            if ! has_key($ssh_key, 'public') {
                fail('The key public is required in ssh_key')
            }

            file {"/home/${account['user_name']}/.ssh/${ssh_key['name']}":
                ensure  => present,
                mode    => '0600',
                owner   => $account['user_name'],
                group   => $account['primary_group'],
                content => $ssh_key['private'],
            }

            file {"/home/${account['user_name']}/.ssh/${ssh_key['name']}.pub":
                ensure  => present,
                mode    => '0644',
                owner   => $account['user_name'],
                group   => $account['primary_group'],
                content => $ssh_key['public'],
            }
        }
    }
}