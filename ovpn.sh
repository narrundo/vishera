#OpenVPN


apt-get -y install openvpn
cp -R /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/
cd /etc/openvpn/2.0
curl -s https://github.com/narrundo/vishera/raw/conf/vars >> vars
source ./vars;
./clean-all;
./build-ca;
./build-dh;
./build-key-server server
mkdir /etc/openvpn/keys/
cp /etc/openvpn/2.0/keys/* /etc/openvpn/keys/
cd /etc/openvpn
rm -Rf 2.0
curl -s https://github.com/narrundo/vishera/raw/conf/995.conf > 995.conf
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 192.168.100.0/255.255.255.0 -j ACCEPT
iptables -A FORWARD -j REJECT --reject-with icmp-port-unreachable
iptables -A POSTROUTING -o venet0 -j SNAT --to-source $IP
