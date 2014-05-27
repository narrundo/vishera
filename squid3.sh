# Try to get our IP Server from the system and fallback to the Internet.
# I do this to make the script compatible with NATed servers (lowendspirit.com)
# and to avoid getting an IPv6.
IP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$IP" = "" ]; then
		IP=$(wget -qO- ipv4.icanhazip.com)
fi


#Squid Proxy 3.1
apt-get install aptitude
aptitude -y install squid3
rm -f /etc/squid3/squid.conf
wget -P /etc/squid3/ "https://raw.githubusercontent.com/narrundo/vishera/conf/squid.conf"
sed -i 's/#cache_dir/cache_dir/g' /etc/squid3/squid.conf
sed -i 's/[ipserver]/$IP/g' /etc/squid3/squid.conf
service squid3 restart

#ViperSSH Config Only
