##
# Configure the samba server
class pp_smb::config() inherits pp_smb {

    class {'samba::server':
        workgroup           => $pp_smb::workgroup,
        server_string       => $pp_smb::server_string,
        interfaces          => $pp_smb::interfaces,
        unix_password_sync  => $pp_smb::unix_password_sync,
        pam_password_change => $pp_smb::pam_password_change,
        map_to_guest        => $pp_smb::map_to_guest,
        guest_account       => $pp_smb::guest_account,
    }

    include pp_smb::config::shares

    include pp_smb::config::firewall
}