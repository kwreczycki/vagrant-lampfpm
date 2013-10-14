define apache::vhost($vhost_domain) {
	file {"/var/www/${vhost_domain}":
	    ensure => directory,
	    mode => 0777,
	    owner => www-data,
	    group => www-data
	}
	file {"/etc/apache2/sites-available/${vhost_domain}.conf":
		content => template("apache/vhost.erb"),
		notify => Exec["enable-${vhost_domain}-vhost"],
	}
	exec {"enable-${vhost_domain}-vhost":
		command => "/usr/sbin/a2ensite ${vhost_domain}.conf",
		refreshonly => true,
		notify => Service["apache2"],
	}
}
