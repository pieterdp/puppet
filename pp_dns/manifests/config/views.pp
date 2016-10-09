##
# Configure DNS views
class pp_dns::config::views() inherits pp_dns {

    each ($pp_dns::views) | $view | {
        validate_hash($view)

        bind::view {$view['name']:
            *   => $view,
        }
    }
}