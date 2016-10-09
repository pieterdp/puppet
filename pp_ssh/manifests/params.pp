##
# Parameter class
class pp_ssh::params {
    $client_kex_algorithms = ['curve25519-sha256@libssh.org', 'diffie-hellman-group-exchange-sha256']
    $client_ciphers = [
      'chacha20-poly1305@openssh.com',
      'aes256-gcm@openssh.com',
      'aes128-gcm@openssh.com',
      'aes256-ctr',
      'aes192-ctr',
      'aes128-ctr'
    ]
    $client_macs = [
        'hmac-sha2-512-etm@openssh.com',
        'hmac-sha2-256-etm@openssh.com',
        'hmac-ripemd160-etm@openssh.com',
        'umac-128-etm@openssh.com',
        'hmac-sha2-512',
        'hmac-sha2-256',
        'hmac-ripemd160',
        'umac-128@openssh.com'
    ]
    $server_host_key = ['/etc/ssh/ssh_host_rsa_key', '/etc/ssh/ssh_host_ed25519_key']
    $server_kex_algorithms = ['curve25519-sha256@libssh.org', 'diffie-hellman-group-exchange-sha256']
    $server_ciphers = [
            'chacha20-poly1305@openssh.com',
            'aes256-gcm@openssh.com',
            'aes128-gcm@openssh.com',
            'aes256-ctr',
            'aes192-ctr',
            'aes128-ctr'
    ]
    $server_macs = [
            'hmac-sha2-512-etm@openssh.com',
            'hmac-sha2-256-etm@openssh.com',
            'hmac-ripemd160-etm@openssh.com',
            'umac-128-etm@openssh.com',
            'hmac-sha2-512',
            'hmac-sha2-256',
            'hmac-ripemd160',
            'umac-128@openssh.com'
    ]
    $server_allow_users = undef
}