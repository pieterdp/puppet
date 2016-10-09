##
# Parameter class
class pp_dns::params {
    $forwarders = ['8.8.8.8', '8.8.4.4']
    $dnssec = true
    $acls = [
        {
            'name' => 'trusted',
            'addresses' => ['127.0.0.1']
        }
    ]
    $views = undef
    $zones = undef
}