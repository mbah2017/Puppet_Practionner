class review (
  $user = 'review',
) {
  file { '/etc/shells':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/review/shells',
  }
  file { '/etc/motd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('review/motd.epp',
    {
      user => $user,
    }),
  }
  user { $user:
    ensure     => present,
    shell      => '/bin/csh',
    managehome => true,
    require    => File['/etc/shells'],
  }
}
