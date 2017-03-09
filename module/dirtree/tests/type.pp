$dirtree = dirtree($::rubysitedir)

notify { $dirtree: }

dirtree { 'a temp dir':
  ensure  => present,
  path    => '/tmp/foo/bar/baz',
  parents => true,
}

dirtree { 'another temp dir with the same path':
  ensure  => present,
  path    => '/tmp/foo/bar/baz',
}

file { '/tmp/foo/bar/baz':
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}
