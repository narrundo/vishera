clear
echo "MusicBot for Discord quick-setup script by narrundo"
sleep 3 
echo "MusicBot by SexualRhinocheros"
echo "17 July 2016"
sleep 2 
echo "initializing..."
sleep 5 

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:fkrull/deadsnakes -y
sudo add-apt-repository ppa:mc3man/trusty-media -y
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential unzip -y
sudo apt-get install git -y
sudo apt-get install python3.5 python3.5-dev -y
sudo apt-get install ffmpeg -y
sudo apt-get install libopus-dev -y
sudo apt-get install libffi-dev -y
sudo apt-get install libsodium-dev -y
wget https://bootstrap.pypa.io/get-pip.py
sudo python3.5 get-pip.py
clear

git clone https://github.com/SexualRhinoceros/MusicBot.git MusicBot -b master
cd MusicBot
sudo -H pip3.5 install --upgrade -r requirements.txt
sudo python3.5 -m pip install --upgrade pip
rm -f run.sh
wget https://github.com/narrundo/vishera/raw/master/MusicBot/run.sh
wget https://github.com/narrundo/vishera/raw/master/MusicBot/startup.sh
chmod 755 run.sh
chmod 755 startup.sh
chown -R root startup.sh
chown -R root run.sh

cd config
wget https://github.com/narrundo/vishera/raw/master/MusicBot/options.ini
wget https://github.com/narrundo/vishera/raw/master/MusicBot/permissions.ini
cd 
cd
sed -i '$ i\sh /root/MusicBot/startup.sh' /etc/rc.local

clear
echo "MusicBot for Discord installation is done !"
echo "go to MusicBot/config and re-configure your permission.ini and options.ini"
echo "you may need to cross-check the parameter with example one due to update!"
echo ""
echo "enjoy :)"
sleep 5

