vagrant-lampfpm
===============

Configuration for setup LAMP enviroment with php-fpm on Vagrant ubuntu precise32 box

setup
---------------
Install vagrant package, clone repository and add hostaname to Your /etc/hosts file, by default it should be:
```
192.168.50.33 vagrant-fpm.dev
```
Hostame can be changed in puppet/manifests/init.pp.
