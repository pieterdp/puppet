##
# Configure apache
class pp_apache::config () inherits pp_apache {

    class {'apache':
        purge_vhost_dir  => true,
        default_vhost    => false,
        default_mods     => $pp_apache::default_mods,
        serveradmin      => $pp_apache::server_admin,
        server_signature => 'Off',
        mpm_module       => 'prefork',
    }

    ##
    # Support for HTTP and HTTPS
    apache::listen {'80': }
    apache::listen {'443': }

    ##
    # We frequently use apache as a front-end for applications running on non-standard
    # ports. So enable mod_proxy, proxy_connect (for SSL) & mod_proxy_http
    class {'apache::mod::proxy': }
    class {'apache::mod::proxy_http': }
    apache::mod {'proxy_connect': }

    ##
    # Secure SSL Configuration
    class {'apache::mod::ssl':
        ssl_cipher           => $pp_apache::ssl_cipher,
        ssl_honorcipherorder => 'On',
        ssl_protocol         => $pp_apache::ssl_protocol,
        ssl_compression      => false,
    }

    ##
    # Some applications contain a .git directory. This directory frequently contains
    # sensitive information. We deny access to it.
    apache::custom_config {'git':
        content => '<Directory ~ "\.git">
        Require all denied
</Directory>',
    }

    ##
    # Firewall configuration
    include pp_apache::config::firewall
}