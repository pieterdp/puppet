##
# Parameter class
class pp_backup::params {
    $backup_user_auth_keys = undef
    $backup_user_ssh_keys = undef
    $enable_mysql_backup = true
    $backup_remote_host_keys = undef
}