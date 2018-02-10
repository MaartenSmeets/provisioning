#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository ppa:webupd8team/java

apt-get update
apt-get -y install aptitude apt-transport-https ca-certificates curl software-properties-common docker-ce docker-compose terminator firefox libxss1 libgconf2-4
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

#Docker stuff
sudo -u course git clone https://github.com/wurstmeister/kafka-docker.git /home/course/kafka-docker

#Start containers
#sudo -u course -- sh -c "cd /home/course/kafka-docker; docker-compose -f docker-compose-single-broker.yml up -d"
#sudo -u course docker run -p 5432:5432 --name postgres-docker -e POSTGRES_PASSWORD=Welcome01 -d postgres
#sudo -u course docker run -p 6379:6379 --name redis-docker -d redis

#Cleanup containers
#docker rm postpres-docker
#docker rm kafkadocker_zookeeper_1
#docker rm kafkadocker_kafka_1

sudo -u course wget http://download.springsource.com/release/STS/3.9.2.RELEASE/dist/e4.7/spring-tool-suite-3.9.2.RELEASE-e4.7.2-linux-gtk-x86_64.tar.gz -O /home/course/sts.tar.gz
sudo -u course -- sh -c "cd /home/course; tar xvfz sts.tar.gz"

sudo -u course wget https://dl.pstmn.io/download/latest/linux64 -O /home/course/postman.tar.gz
sudo -u course -- sh -c "cd /home/course; tar xvfz postman.tar.gz"

sudo -u course wget http://www.kafkatool.com/download2/kafkatool.sh -O /home/course/kafkatool.sh

#sudo -u course git clone https://github.com/MaartenSmeets/springboot.git /home/course/springboot
#/home/course/sts-bundle/sts-3.9.2.RELEASE/STS -data /home/course/springboot

shutdown -P now

