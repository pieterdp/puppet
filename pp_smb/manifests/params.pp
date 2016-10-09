##
# Parameter class
class pp_smb::params {
    $workgroup = 'OFFICE'
    $server_string = '%h server'
#    $interfaces = 'p2p1 tun0'
    $interfaces = 'eth0'
    $unix_password_sync = 'yes'
    $pam_password_change = 'yes'
    $map_to_guest = 'bad user'
    $guest_account = 'nobody'
    $shares = undef
}