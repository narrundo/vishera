# Specify our IP Server
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";


#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
rm -f /etc/squid3/squid.conf
wget -P /etc/squid3/ "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
sed -i "s/ipserver/$MYIP2/g" /etc/squid3/squid.conf
service squid3 restart

#by VisheraCatalyt
#compiled based bunch of reference and open source on Internet :)
