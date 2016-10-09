##
# Parameter class
class pp_webmin::params {
    $webmin_fqdn = "webmin.${::networking['domain']}"
    $usermin_fqdn = "usermin.${::networking['domain']}"
}