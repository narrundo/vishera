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