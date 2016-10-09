##
# Configure the DNS server
class pp_dns::config() inherits pp_dns {

    class {'bind':
        forwarders => $pp_dns::forwarders,
        dnssec     => $pp_dns::dnssec
    }

    ##
    # Configure ACLs before we include other
    # configurations as they might rely on them.
    each ($pp_dns::acls) | $acl | {
        validate_hash($acl)
        validate_array($acl['addresses'])

        bind::acl {$acl['name']:
            addresses => $acl['addresses'],
        }
    }

    include pp_dns::config::zones
    include pp_dns::config::views
}