##
# Configure the backup user
class pp_backup::config::user () inherits pp_backup {

    include pp_accounts

    pp_accounts::account {'rdiff-backup':
        authorized_keys => $pp_backup::backup_user_auth_keys,
        ssh_keys        => $pp_backup::backup_user_ssh_keys,
    }

    sudo::conf {'backup':
        content => 'rdiff-backup ALL=(root) NOPASSWD: /usr/bin/rdiff-backup',
    }
}
