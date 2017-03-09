Class system::dbadmins {

require mysql::server

mysql_user {
   ensure => present,
   max_querires_per_hours => 600,
 }
mysql_user { 'zack@localhost':
  ensure => present,
  max_queries_per_hour => 1200,
 }
mysql_user { ['luke@localhost', 'luike@localhost','mbah@localhost']:
}
}


