#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
add-apt-repository ppa:linuxuprising/java

apt-get update
apt-get -y install jq aptitude apt-transport-https ca-certificates curl software-properties-common docker-ce docker-compose libxss1 libgconf2-4
aptitude -y install --without-recommends ubuntu-desktop 
#Fix root not allowed to start X-window
xhost local:root
apt-get -y install terminator firefox

#developer user
useradd -d /home/developer -m developer
echo -e "Welcome01\nWelcome01" | passwd developer
usermod -a -G vboxsf developer
usermod -a -G docker developer
usermod -a -G sudo developer
usermod --shell /bin/bash developer

#JDK
echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selections
apt-get -y install oracle-java11-installer
apt-get -y install oracle-java11-set-default

#Fix screen flickering issue
sudo perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

#Add additional swap space
#fallocate -l 4G /swapfile
#chmod 600 /swapfile
#mkswap /swapfile
#swapon /swapfile
#echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

#Node
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y nodejs

#Kafka
#sudo -u developer wget http://www.kafkatool.com/download2/kafkatool.sh -O /home/developer/kafkatool.sh
#sudo -u developer git clone https://github.com/confluentinc/kafka-workshop.git /home/developer/kafka-workshop

#Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
sudo apt-get install code 

#Postman
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz
sudo tar -xzf /tmp/postman.tar.gz -C /opt
rm /tmp/postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman

#Soap UI
#wget https://s3.amazonaws.com/downloads.eviware/soapuios/5.4.0/SoapUI-x64-5.4.0.sh

#STS
sudo -u developer wget https://download.springsource.com/release/STS/3.9.6.RELEASE/dist/e4.9/spring-tool-suite-3.9.6.RELEASE-e4.9.0-linux-gtk-x86_64.tar.gz -O /home/developer/sts.tar.gz
sudo -u developer -- sh -c "cd /home/developer; tar xvfz sts.tar.gz"
sudo -u developer -- sh -c "rm /home/developer/sts.tar.gz"


apt-get autoremove
apt-get clean

shutdown now -h