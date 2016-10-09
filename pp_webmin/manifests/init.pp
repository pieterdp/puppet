##
# Install and configure Webmin and Usermin
# Requires roles::webserver::httpserver
class pp_webmin (
    $webmin_fqdn = $pp_webmin::params::webmin_fqdn,
    $usermin_fqdn = $pp_webmin::params::usermin_fqdn,
)
inherits pp_webmin::params {

    include pp_webmin::install
    include pp_webmin::config
    include pp_webmin::install::usermin
    include pp_webmin::config::usermin
}