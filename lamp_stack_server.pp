package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure => installed,
  require => Package['apache2'],  # Ensure Apache is installed first
}

package { 'libapache2-mod-php':
  ensure => installed,
  require => Package['php'],  # Ensure PHP is installed first
}

package { 'php-cli':
  ensure => installed,
  require => Package['php'],  # Ensure PHP is installed first
}

package { 'php-mysql':
  ensure => installed,
  require => Package['php'],  # Ensure PHP is installed first
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], Package['php'], Package['libapache2-mod-php'], Package['php-cli']],
}

file { '/var/www/html/phpinfo.php':
  source => 'file:///home/meye3469/nm_inet4031_puppet_lab9/phpinfo.php',  # Correct path
  notify => Service['apache2'],  # Notify Apache to restart when the file changes
  require => Package['apache2'],  # Ensure Apache is installed before creating the file
}

package { 'mariadb-server':
  ensure => installed,
}
