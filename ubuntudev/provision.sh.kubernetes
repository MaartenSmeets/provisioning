#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-cache policy docker-ce

#Also xenial for old Docker version for running Minikube locally 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
add-apt-repository ppa:linuxuprising/java

apt-get update
apt-get -y install terminator firefox jq aptitude apt-transport-https ca-certificates gnupg2 curl software-properties-common docker-ce=17.03.3~ce-0~ubuntu-xenial docker-compose libxss1 libgconf2-4 evince socat maven
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

#JDK
echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selections
apt-get -y install oracle-java11-installer
apt-get -y install oracle-java11-set-default

#Fix screen flickering issue
perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

cp /etc/sudoers.d/vagrant /etc/sudoers.d/developer
sed -i 's/vagrant/developer/g' /etc/sudoers.d/developer

#STS
sudo -u developer wget https://download.springsource.com/release/STS/3.9.7.RELEASE/dist/e4.10/spring-tool-suite-3.9.7.RELEASE-e4.10.0-linux-gtk-x86_64.tar.gz -O /home/developer/sts.tar.gz
sudo -u developer -- sh -c "cd /home/developer; tar xvfz sts.tar.gz"
sudo -u developer -- sh -c "rm /home/developer/sts.tar.gz"
cat <<EOT >> /usr/share/applications/STS.desktop
[Desktop Entry]
Name=SpringSource Tool Suite
Comment=SpringSource Tool Suite
Exec=/home/developer/sts-bundle/sts-3.9.7.RELEASE/STS
Icon=/home/developer/sts-bundle/sts-3.9.7.RELEASE/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOT

#Install kubectl, minikube, helm
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/
snap install helm --classic

apt-get autoremove
apt-get clean

shutdown now -h
