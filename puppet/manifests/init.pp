node default {
    include webserver
    apache::vhost {'developer-site':
	vhost_domain => 'kwreczycki-sf.dev',
	docroot => '/var/www/kwreczycki'
    }
}
