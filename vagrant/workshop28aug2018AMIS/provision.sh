apt-get update
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common
add-apt-repository ppa:linuxuprising/java

apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java10-installer
apt-get -y install oracle-java10-set-default

aptitude -y install --without-recommends ubuntu-desktop
apt-get -y install firefox terminator

#Add user develop with password Welcome01
useradd -d /home/develop -m develop
echo -e "Welcome01\nWelcome01" | passwd develop
usermod -a -G vboxsf develop
usermod -a -G docker develop
usermod -a -G sudo develop
usermod --shell /bin/bash develop

#Fix screen flickering issue
sudo perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf

#Hide user vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant
