$roothome = homedir('root')
$testhome = homedir('test')
notify { "Root's home directory is ${roothome}": }
notify { "Test's home directory is ${testhome}": }
