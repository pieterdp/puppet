##
# Configure and install the PACKED Samba server
class pp_smb (
    $workgroup = $pp_smb::params::workgroup,
    $server_string = $pp_smb::params::server_string,
    $interfaces = $pp_smb::params::interfaces,
    $unix_password_sync = $pp_smb::params::unix_password_sync,
    $pam_password_change = $pp_smb::params::pam_password_change,
    $map_to_guest = $pp_smb::params::map_to_guest,
    $guest_account = $pp_smb::params::guest_account,
    $shares = $pp_smb::params::shares
) inherits pp_smb::params {
    validate_array($shares)

    include pp_smb::install
    include pp_smb::config
}