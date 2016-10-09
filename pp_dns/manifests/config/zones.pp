##
# Configure bind zones
class pp_dns::config::zones() inherits pp_dns {
    each ($pp_dns::zones) | $zone | {
        validate_hash($zone)

        bind::zone {$zone['name']:
            * => $zone,
        }
    }
}