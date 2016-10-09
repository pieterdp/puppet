##
# Backup class
class pp_backup (
    $backup_user_auth_keys = $pp_backup::params::backup_user_auth_keys,
    $backup_user_ssh_keys = $pp_backup::params::backup_user_ssh_keys,
    $enable_mysql_backup = $pp_backup::params::enable_mysql_backup,
    $backup_remote_host_keys = $pp_backup::params::backup_remote_host_keys,
) inherits pp_backup::params {

    validate_array($backup_user_ssh_keys)
    validate_array($backup_user_auth_keys)
    validate_array($backup_remote_host_keys)

    each($backup_remote_host_keys) | $key | {
        validate_hash($key)
        if ! has_key($key, 'key') {
            fail('Every remote host key must have a key "key"')
        }
        if ! has_key($key, 'type') {
            fail('Every remote host key must have a key "type"')
        }
    }

    ##
    # We need to configure the user first, or otherwise the scripts
    # and script directory won't have the correct owner
    include pp_backup::config::user

    include pp_backup::install
    include pp_backup::config
    include pp_backup::service
}