#!/bin/bash

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
mv /etc/apt/sources.list /etc/apt/sources.list.old
echo "deb http://ftp.debian.org/debian wheezy main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ wheezy/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update;apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli php5-mysql

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois sslh ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i venet0
service vnstat restart

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
curl http://script.jualssh.com/nginx.conf > /etc/nginx/nginx.conf
curl http://script.jualssh.com/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "ViperSSH © 2014 | Contact Person : 089668629072 (WhatsApp)" > /home/vps/public_html/index.html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
service php5-fpm restart
service nginx restart


# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
curl -o /etc/squid/squid.conf "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
service squid3 restart

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart


# install webmin
cd
apt-get update
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.660_all.deb"
dpkg --install webmin_1.660_all.deb;
apt-get -y -f install;
rm /root/webmin_1.660_all.deb
service webmin restart

#OpenVPN "road-warrior"
cd 
wget https://raw.githubusercontent.com/narrundo/vishera/autoscript/openvpn.sh
chmod 100 openvpn.sh
./openvpn.sh

# info
clear
echo "Vishera Catalyst - autoscript install for debian 7"
echo "Installed Service"
echo "---------------------------------------------------------------"
echo "OpenVPN  : TCP 1194 | config downloadable on ~/ovpn-client.tar.gz"
echo "OpenSSH  : 22, 143"
echo "Dropbear : 109, 110, 443"
echo "Squid    : 8080 (limit to IP SSH)"
echo ""
echo "Fitur lain"
echo "---------------------------------------------------------------"
echo "Webmin   : https://$MYIP:10000/"
echo "vnstat   : http://$MYIP/vnstat/"
echo "MRTG     : http://$MYIP/mrtg/"
echo "Timezone : Asia/Jakarta"
echo "Fail2Ban : [on]"
echo "IPv6     : [off]"
echo ""
echo "Please reboot your system now !"
echo ""
echo ""
