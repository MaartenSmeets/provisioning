#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository ppa:webupd8team/java

apt-get update
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common docker-ce docker-compose terminator firefox
aptitude -y install --without-recommends ubuntu-desktop 

#course user
useradd -d /home/course -m course
echo -e "Welcome01\nWelcome01" | passwd course
usermod -a -G vboxsf course
usermod -a -G docker course
usermod -a -G sudo course

cd /software

#JDK
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

sudo -u course git clone https://github.com/wurstmeister/kafka-docker.git /home/course/kafka-docker
sudo -u course -- sh -c "cd /home/course/kafka-docker; docker-compose -f docker-compose-single-broker.yml up -d"

#shutdown -P now

