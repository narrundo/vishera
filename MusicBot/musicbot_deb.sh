clear
echo "MusicBot for Discord quick-setup script by narrundo"
sleep 3 
echo "MusicBot by SexualRhinocheros"
echo "version 1.9.5 review-branch"
sleep 2 
echo "initializing..."
sleep 5 

 apt-get install software-properties-common -y
 add-apt-repository ppa:fkrull/deadsnakes -y
 add-apt-repository ppa:mc3man/trusty-media -y
 apt-get update -y
 apt-get upgrade -y
 apt-get install build-essential unzip -y
 apt-get install git -y
 apt-get install python3.5 python3.5-dev -y
 apt-get install ffmpeg -y
 apt-get install libopus-dev -y
 apt-get install libffi-dev -y
 apt-get install libsodium-dev -y
wget https://bootstrap.pypa.io/get-pip.py
 python3.5 get-pip.py

git clone https://github.com/SexualRhinoceros/MusicBot.git MusicBot
cd MusicBot
git checkout review
 -H pip3.5 install --upgrade -r requirements.txt
rm -f run.sh
wget https://github.com/narrundo/vishera/raw/master/MusicBot/run.sh
wget https://github.com/narrundo/vishera/raw/master/MusicBot/startup.sh
chmod 755 run.sh
chmod 755 startup.sh
chown -R root startup.sh
chown -R root run.sh

cd config
wget https://github.com/narrundo/vishera/raw/master/MusicBot/permissions.ini
wget https://github.com/narrundo/vishera/raw/master/MusicBot/permissions.ini
cd cd
sed -i '$ i\sh /root/MusicBot/startup.sh' /etc/rc.local

echo "MusicBot for Discord installation is done !"
echo "go to MusicBot/config and re-configure your permission.ini and options.ini"
echo "you may need to cross-check the parameter with example one due to update!"
echo ""
echo "enjoy :)"
sleep 5
clear
