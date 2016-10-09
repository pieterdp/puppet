##
# Default rules to apply before any custom rules
class pp_firewall::config::pre () inherits pp_firewall {

    include pp_firewall::config::pre::ipv4
    include pp_firewall::config::pre::ipv6
}