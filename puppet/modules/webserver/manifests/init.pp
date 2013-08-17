class webserver {
	package { 'apache2':
	    ensure => installed;
	}
	exec { 'reload-apache2':
	    command => "/etc/init.d/apache2 reload"
	}
	service { 'apache2':
	    ensure => running,
	    require => Package["apache2"]
	}
	package { ['mysql-server', 'mysql-client']:
	    ensure => installed;
	}
	service { 'mysql':
	    ensure => running,
	    require => Package["mysql-server"]
	}
}
