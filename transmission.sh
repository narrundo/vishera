# Specify our IP Server
if [ "$IP" = "" ]; then
IP=$(curl -s ifconfig.me)
fi

#tranmision-daemon
apt-get update
apt-get install transmission-daemon
wget -O /etc/transmission-daemon/settings.json "http://sourceforge.net/projects/narrundo/files/conf/settings.json.transmission"
service transmission-daemon reload

#Apache2
apt-get install apache2

#folder Download
cd /var/www
ln -s /var/lib/transmission-daemon/downloads

# info
clear
echo "Vishera Catalyst" | tee log-install.txt
echo "==================================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Pastikan Tidak Ada Port 80 Berjalan Selain Apache2"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo "Tranmision Torrent : $IP:9091"  | tee -a log-install.txt
echo "Tranmision File    : $IP/downloads"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo "Username : daemontorrent"  | tee -a log-install.txt
echo "Password : admin"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "=================================================="  | tee -a log-install.txt 
