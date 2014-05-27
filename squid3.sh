# Specify our IP Server
if [ "$IP" = "" ]; then
        IP=$(curl -s ifconfig.me)
fi

#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
rm -f /etc/squid3/squid.conf
wget -P /etc/squid3/ "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
sed -i "s/ipserver/$IP/g" /etc/squid3/squid.conf
service squid3 restart

#by VisheraCatalyt
#compiled based bunch of reference and open source on Internet :)
