##
# Installation
class pp_apache::install() inherits pp_apache {

    file {'/var/www':
        ensure => directory,
    }
}