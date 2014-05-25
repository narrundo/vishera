#!/bin/bash

# go to root
cd

#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
