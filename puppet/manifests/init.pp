node default {
    include webserver
    apache::vhost {'developer-site':
	vhost_domain => 'vagrant-fpm.dev'
    }
}
