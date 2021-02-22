#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-cache policy docker-ce

#Also xenial for old Docker version for running Minikube locally 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt-get update
apt-get -y install terminator firefox jq aptitude apt-transport-https ca-certificates gnupg2 curl software-properties-common docker-ce docker-compose libxss1 libgconf-2-4 evince socat maven openjdk-11-jdk aptitude
aptitude -y install --without-recommends ubuntu-desktop 
#Fix root not allowed to start X-window
xhost local:root

#developer user
useradd -d /home/developer -m developer
echo -e "Welcome01\nWelcome01" | passwd developer
usermod -a -G vboxsf developer
usermod -a -G docker developer
usermod -a -G sudo developer
usermod --shell /bin/bash developer

#Fix screen flickering issue
#perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

cp /etc/sudoers.d/vagrant /etc/sudoers.d/developer
sed -i 's/vagrant/developer/g' /etc/sudoers.d/developer

apt-get autoremove
apt-get clean

#Doing some settings for Elasticsearch
#sysctl -w vm.max_map_count=262144
#sysctl -w fs.file-max=65536
#ulimit -n 65536
#ulimit -u 4096
#Below makes the above permanent
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=65536" >> /etc/sysctl.conf
echo "* soft nofile 65536" >> cat /etc/security/limits.conf
echo "* hard nofile 65536" >> cat /etc/security/limits.conf
echo "* soft nproc 4096" >> cat /etc/security/limits.conf
echo "* hard nproc 4096" >> cat /etc/security/limits.conf
mkdir /home/developer/comp
cp docker-compose.yml /home/developer/comp
#Obtain Jenkins password after docker-compose up
#docker exec -it comp_jenkins_1 cat ./var/jenkins_home/secrets/initialAdminPassword
shutdown now -h
