include showoff

# This depends on you configuring an sshkey in hiera
$sshkey = hiera('sshkey')
$github_host_key = "AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="

file { "/home/${showoff::user}/.ssh/id_rsa":
  ensure  => file,
  owner   => $showoff::user,
  group   => $showoff::group,
  mode    => '0600',
  content => $sshkey,
  require => Class['showoff'],
}

sshkey { 'github key':
  name         => 'github.com',
  host_aliases => '192.30.252.129',
  type         => 'ssh-rsa',
  target       => "/home/${showoff::user}/.ssh/known_hosts",
  key          => $github_host_key,
}

vcsrepo { "${showoff::root}/courseware":
  ensure   => present,
  provider => git,
  user     => $showoff::user,
  source   => 'git@github.com:puppetlabs/courseware.git',
  require  => Sshkey['github key'],
}

showoff::presentation { 'fundamentals':
  path       => "${showoff::root}/courseware/fundamentals",
  allow_exec => true,
  require    => Vcsrepo["${showoff::root}/courseware"],
}
showoff::presentation { 'practitioner':
  path       => "${showoff::root}/courseware/practitioner",
  port       => '9091',
  require    => Vcsrepo["${showoff::root}/courseware"],
}
