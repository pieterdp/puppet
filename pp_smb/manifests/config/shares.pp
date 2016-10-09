##
# Configure all shares in $pp_smb::shares
class pp_smb::config::shares() inherits pp_smb {

    each($pp_smb::shares) | $share | {
        validate_hash($share)

        if ! defined(File[$share['options']['path']]) {
            file {$share['options']['path']:
                ensure => directory,
            }
        }

        samba::server::share { $share['name']:
            * => $share['options']
        }
    }
}