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
	service { 'php5-fpm':
	    ensure => running,
	    require => Package["php5-fpm"]
	}
	exec {'enable-mod':
	    command => "/usr/sbin/a2enmod actions fastcgi alias"
	}
        exec {'disable-default':
            command => "/usr/sbin/a2dissite 000-default",
            notify => Exec["reload-apache2"]
        }
	file {'/etc/apache2/mods-available/fastcgi.conf':
            ensure => present,
	    content => template('webserver/fastcgi.conf.erb'),
            owner => 'root',
            group => 'root',
	    mode => 0644,
	}	
}
