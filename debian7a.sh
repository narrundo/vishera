#!/bin/bash

# go to root
cd

# Specify our IP Server
if [ "$IP" = "" ]; then
IP=$(curl -s ifconfig.me)
fi

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
rm -f /etc/squid3/squid.conf
wget -P /etc/squid3/ "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
sed -i "s/ipserver/$IP/g" /etc/squid3/squid.conf
service squid3 restart

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart


# install webmin
cd
apt-get update
wget http://sourceforge.net/projects/webadmin/files/webmin/1.690/webmin-1.690.zip
dpkg --install webmin_1.660_all.deb;
apt-get -y -f install;
rm /root/webmin_1.660_all.deb
service webmin restart

#Install BadVPN
# install badvpn
wget -O /usr/bin/badvpn-udpgw "http://kenyangssh.com/autoscrip/file/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

#Install SSH-HPN
apt-get install zlib1g-dev libpam-dev libssl-dev openssl build-essential
wget http://mirror.esc7.net/pub/OpenBSD/OpenSSH/portable/openssh-6.6p1.tar.gz
wget http://sourceforge.net/projects/hpnssh/files/HPN-SSH%2014.5%206.6p1/openssh-6.6p1-hpnssh14v5.diff.gz
tar -xzvf openssh-6.6p1.tar.gz
cd openssh-6.6p1.tar.gz
zcat ../openssh-6.6p1-hpnssh14v5.diff.gz | patch
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-pam
rm /etc/ssh/ssh_config
rm /etc/ssh/sshd_config
make && make install
service ssh restart

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# info
clear
echo "Vishera Catalyst - autoscript install for debian 7"
echo "Installed Service"
echo "---------------------------------------------------------------"
echo "OpenSSH  : 22, 143"
echo "Dropbear : 109, 110, 443"
echo "Squid    : 80, 8080 (limit to IP SSH)"
echo ""
echo "Misc"
echo "---------------------------------------------------------------"
echo "Webmin   : https://$IP:10000/"
echo "vnstat   : http://$IP/vnstat/"
echo "Timezone : Asia/Jakarta"
echo "Fail2Ban : [on]"
echo "IPv6     : [off]"
echo ""
echo "Please reboot your system now !"
echo ""
echo ""
