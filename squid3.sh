#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
wget -P /etc/squid3/ "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
service squid3 restart

#ViperSSH Config Only
