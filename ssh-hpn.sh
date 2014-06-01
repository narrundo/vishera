#Install SSH-HPN
apt-get install zlib1g-dev libpam-dev libssl-dev openssl build-essential
wget http://mirror.esc7.net/pub/OpenBSD/OpenSSH/portable/openssh-6.6p1.tar.gz
wget http://sourceforge.net/projects/hpnssh/files/HPN-SSH%2014.5%206.6p1/openssh-6.6p1-hpnssh14v5.diff.gz
tar -xzvf openssh-6.6p1.tar.gz
cd openssh-6.6p1
zcat ../openssh-6.6p1-hpnssh14v5.diff.gz | patch
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-pam
rm /etc/ssh/ssh_config
rm /etc/ssh/sshd_config
make && make install
service ssh restart
