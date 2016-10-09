##
# Configuration class
class pp_ssh::config () inherits pp_ssh {

    include pp_ssh::config::client
    include pp_ssh::config::server
}