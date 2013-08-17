class webserver {
	package { 'apache2-mpm-worker':
	    ensure => installed;
	}
	exec { 'reload-apache2':
	    command => "/etc/init.d/apache2 reload"
	}
	service { 'apache2':
	    ensure => running,
	    require => Package["apache2-mpm-worker"]
	}
	package { ['mysql-server', 'mysql-client', 'libapache2-mod-fastcgi', 'php5-fpm', 'php5', 'php5-mysql']:
	    ensure => installed;
	}
	service { 'mysql':
	    ensure => running,
	    require => Package["mysql-server"]
	}
	exec {'enable-mod':
	    command => "/usr/sbin/a2enmod actions fastcgi alias"
	}
}
