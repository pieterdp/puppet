##
# Configure update policy for apt
class pp_upgrades::config::apt () inherits pp_upgrades {

    include apt

    ##
    # Configure unattended upgrades

    # Periodic checks
    apt::conf {'unattended_upgrades_periodic':
        content  => 'APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";',
        priority => 10,
    }

    # Unattedend upgrades - allowed origins
    apt::conf {'unattended_upgrades_allowed_origins':
        content => 'Unattended-Upgrade::Allowed-Origins {
	"${distro_id}:${distro_codename}-security";
	"${distro_id}:${distro_codename}-updates";
};'
    }
}