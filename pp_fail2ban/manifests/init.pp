##
# Enable fail2ban with jail.local from files
class pp_fail2ban () {

    include pp_fail2ban::install
    include pp_fail2ban::config
    include pp_fail2ban::service
}