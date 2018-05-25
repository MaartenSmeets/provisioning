#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository ppa:webupd8team/java

#R
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu artful/'

apt-get update
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common docker-ce docker-compose libxss1 libgconf2-4 
aptitude -y install --without-recommends ubuntu-desktop 
#Fix root not allowed to start X-window
xhost local:root
apt-get -y install terminator firefox gparted

#JDK
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

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
echo 'install.packages("tree", lib.loc="~/R/x86_64-pc-linux-gnu-library-3.4")' > /home/developer/install.R
echo 'install.packages("randomForest", lib.loc="~/R/x86_64-pc-linux-gnu-library-3.4")' >> /home/developer/install.R
chown developer.developer /home/developer/install.R
sudo -u developer -- sh -c "Rscript /home/developer/install.R"

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

shutdown now -h
