#tranmision-daemon
apt-get update
apt-get install transmission-daemon
wget -O /etc/transmission-daemon/settings.json "https://sourceforge.net/projects/narrundo/files/settings.json.transmission"
service transmission-daemon reload

#Apache2
apt-get install apache2

#folder Download
cd /var/www
ln -s /var/lib/transmission-daemon/downloads

# info
clear
echo "Vishera Catalyst" | tee log-install.txt
echo "==============================================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Pastikan Tidak Ada Port 80 Berjalan Selain Apache2"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo "Tranmision Torrent : IP-VPS-Anda:9091"  | tee -a log-install.txt
echo "Tranmision File    : IP-VPS-Anda/downloads"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo "Username : admin"  | tee -a log-install.txt
echo "Password : daemontorrent"  | tee -a log-install.txt
echo "--------------------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "=============================================================="  | tee -a log-install.txt 
