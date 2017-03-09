class hosts {
  # Uncomment this resource to purge unmanaged host records.
  resources {'host':
   purge => true,
  }
  host { 'master.puppetlabs.vm':
    ensure       => 'present',
    host_aliases => ['master'],
    ip           => '10.0.20.103',
  }
  host { 'localhost.localdomain':
    ensure       => 'present',
    host_aliases => ['localhost'],
    ip           => '127.0.0.1',
  }
  @@host { $::fqdn:
    ensure       => 'present',
    host_aliases => [$::hostname],
    ip           => $::ipaddress,
    tag          => 'classroom',
  }
  Host <<| tag == 'classroom' |>>
} 
