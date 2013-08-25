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
	package { ['mysql-server', 'mysql-client', 'libapache2-mod-fastcgi', 'php5-fpm', 'php5', 'php5-mysql', 'libaugeas-ruby', 'augeas-tools']:
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
	augeas { "mod_fcgi":
		context => "/files/etc/apache2/mods-available/fastcgi.conf/IfModule/",
	    changes => [
			"set *[self::directive='AddHandler']/arg[1] php5-fcgi",
			"set *[self::directive='AddHandler']/arg[2] .php",
			"set *[self::directive='Action']/arg[1] php5-fcgi",
			"set *[self::directive='Action']/arg[2] /php5-fcgi",
			"set *[self::directive='Alias']/arg[1] /php5-fcgi",
			"set *[self::directive='Alias']/arg[2] /usr/lib/cgi-bin/php5-fcgi",
			"set *[self::directive='FastCgiExternalServer']/arg '\"/usr/lib/cgi-bin/php5-fcgi -socket /var/run/php5-fpm.sock -pass-header Authorization\"'",
	    ],
	    notify => Exec['remove-double-quotes']
	}
	exec {'remove-double-quotes':
		command => '/bin/cat /etc/apache2/mods-available/fastcgi.conf | /usr/bin/tr -d \'"\' > /tmp/foo && mv /tmp/foo /etc/apache2/mods-available/fastcgi.conf'	
	}
}
