##
# Configure webmin and usermin
# Includes Apache VHost configuration; requires pp_apache
class pp_webmin::config () inherits pp_webmin {

    include pp_apache
    include pp_webmin::config::ssl

    ##
    # Create (empty) document roots. apache::vhost requires a document root that exists
    file {"/var/www/${pp_webmin::webmin_fqdn}":
        ensure => directory,
    }

    file {"/var/www/${pp_webmin::webmin_fqdn}/html":
        ensure => directory,
    }

    ##
    # Add a virtual host
    apache::vhost {"${pp_webmin::webmin_fqdn}_80":
        servername      => $pp_webmin::webmin_fqdn,
        port            => '80',
        docroot         => "/var/www/${pp_webmin::webmin_fqdn}/html",
        docroot_owner   => 'www-data',
        docroot_group   => 'www-data',
        redirect_status => 'permanent',
        redirect_dest   => "https://${pp_webmin::webmin_fqdn}/",
    }

    ##
    # For something as sensitive as webmin, HTTPS is the only solution
    apache::vhost {"${pp_webmin::webmin_fqdn}_443":
        servername      => $pp_webmin::webmin_fqdn,
        port            => '443',
        docroot         => "/var/www/${pp_webmin::webmin_fqdn}/html",
        docroot_owner   => 'www-data',
        docroot_group   => 'www-data',
        ssl             => true,
        ssl_cert        => '/etc/ssl/certs/cert.crt',
        ssl_key         => '/etc/ssl/private/key.key',
        directories     => [
            {
                path    => "/var/www/${pp_webmin::webmin_fqdn}/html",
                require => ['all denied'],
            }
        ],
        headers         => [
            'always set Strict-Transport-Security "max-age=63072000; includeSubdomains;"',
        ],
        custom_fragment => 'SSLProxyEngine On
        SSLProxyVerify none
        SSLProxyCheckPeerCN off
        SSLProxyCheckPeerName off
        SSLProxyCheckPeerExpire off
        ProxyRequests Off
        ProxyPass / https://localhost:10000/
        ProxyPassReverse / https://localhost:10000/',
        require         => []
    }
}