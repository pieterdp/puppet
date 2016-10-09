##
# Account resource type
# $username and $primary_group default to $title
# $password is optional
# $groups is optional - if you want to active the default sudo
#       behaviour, add 'sudo' to $groups
# $authorized_keys is optional, but if set, must be
# an array containing hashes with the following keys:
#   id
#   type
#   key
# $ssh_keys contains the private/public key pairs to
# install (optional). Must be an array of hashes with the following keys:
#   name: name of the private key. The public one will have .pub appended
#   private: the private key (as string - use eyaml)
#   public: the public key (as string)
define pp_accounts::account (
    $user_name = $title,
    $primary_group = $title,
    $password = undef,
    $groups = [],
    $authorized_keys = [],
    $ssh_keys = [],
) {
    validate_array($authorized_keys)
    validate_array($ssh_keys)

    if ! defined(Class['pp_accounts']) {
        fail('You must include/define pp_accounts before using pp_accounts::account')
    }

    $account_data = [
        {
            'user_name'       => $user_name,
            'primary_group'   => $primary_group,
            'groups'          => $groups,
            'password'        => $password,
            'authorized_keys' => $authorized_keys,
            'ssh_keys'        => $ssh_keys,
        }
    ]

    ##
    # 

    pp_accounts::config::user {$user_name:
        account_data => $account_data,
    }

}