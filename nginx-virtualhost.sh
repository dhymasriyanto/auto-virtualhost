#!/usr/bin/env bash

### Setting up default default variable and assign default value

action=$1
domain=$2
rootDir=$3
owner=$(who am i | awk '{print $1}')
enabledSites='/etc/nginx/sites-enabled/'
availableSites='/etc/nginx/sites-available/'
dirPath='/var/www/html'
domainAvailable=$availableSites$domain.conf

### Checking Up isRoot user and not given domain name

if [ "$(whoami)" != 'root' ]; then
	echo -e $"\nYou dont have permission to run this script please login as root with sudo -s or use sudo.\n"
		exit 1;
fi

if [ "$action" != 'create' ] && [ "$action" != 'delete' ] && [ "$action" != 'list' ]
	then
		echo -e $"\nPlease Use create or delete or list as action.\n"
		exit 1;
fi

if [ "$action" == 'list' ]
	then
		echo -e $"\n********************\n"
		### command for list
		grep server_name /etc/nginx/sites-enabled/* -RiI
		echo -e $"\n********************\n"
		exit;
fi

while [ "$domain" == '' ]; do
	echo -e $"Please give a domain name like nayeem.test or web.dev :"
	read domain
done