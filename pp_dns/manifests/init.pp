##
# Configure the BIND DNS server
# Uses inkblot/bind
class pp_dns(
    $forwarders = $pp_dns::params::forwarders,
    $dnssec = $pp_dns::params::dnssec,
    $acls = $pp_dns::params::acls,
    $views = $pp_dns::params::views,
    $zones = $pp_dns::params::zones,
) inherits pp_dns::params {
    validate_array($acls)
    validate_array($views)
    validate_array($zones)

    include pp_dns::install
    include pp_dns::config
}