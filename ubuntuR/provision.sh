#Docker
curl -fsSL test.docker.com | sh

#Java
add-apt-repository ppa:linuxuprising/java

#R
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu artful/'

#Install some packages, GUI
apt-get update
apt-get upgrade       # Strictly upgrades the current packages
apt-get dist-upgrade  # Installs updates (new ones)
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common libxss1 libgconf2-4 
aptitude -y install --without-recommends ubuntu-desktop 
#Fix root not allowed to start X-window
xhost local:root
apt-get -y install terminator firefox gparted

#JDK
echo oracle-java10-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java10-installer
apt -y install oracle-java10-set-default

#Fix screen flickering issue
sudo perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf
#sudo -u developer git clone https://github.com/MaartenSmeets/springboot.git /home/developer/springboot
#For starting STS (after git clone above): /home/developer/sts-bundle/sts-3.9.2.RELEASE/STS -data /home/developer/springboot

#R studio
apt-get -y install r-base
wget https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb -O ~/rstudio.deb
apt -y install ~/rstudio.deb
rm ~/rstudio.deb

#developer user
useradd -d /home/developer -m developer
echo -e "Welcome01\nWelcome01" | passwd developer
usermod -a -G vboxsf developer
usermod -a -G docker developer
usermod -a -G sudo developer

#install packages
sudo -u developer -- sh -c "mkdir -p /home/developer/R/x86_64-pc-linux-gnu-library-3.4"
echo 'install.packages("tree", lib="/home/developer/R/x86_64-pc-linux-gnu-library-3.4")' > /home/developer/install.R
echo 'install.packages("randomForest", lib="/home/developer/R/x86_64-pc-linux-gnu-library-3.4")' >> /home/developer/install.R
chown developer.developer /home/developer/install.R
sudo -u developer -- sh -c "Rscript /home/developer/install.R"

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

shutdown now -h
