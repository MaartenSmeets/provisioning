apt-get update
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common unity-lens-applications unity-lens-files

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer
sudo apt-get -y install oracle-java8-set-default

aptitude -y install --without-recommends ubuntu-desktop
apt-get -y install firefox terminator

#Add user develop with password Welcome01
useradd -d /home/myuser -m myuser
echo -e "Welcome01\nWelcome01" | passwd myuser
usermod -a -G vboxsf myuser
usermod -a -G docker myuser
usermod -a -G sudo myuser
usermod --shell /bin/bash myuser

#Hide user vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant
