useradd -d /home/course -m course
echo Welcome01 | passwd course --stdin
usermod -a -G vboxsf course

cd /software

#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#rpm -ivh epel-release-latest-7.noarch.rpm
#yum -y install gparted

#Docker
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
	
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get install docker-ce

#Desktop
apt-get install aptitude
aptitude install --without-recommends ubuntu-desktop

apt-get install terminator

#JDK
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  
add-apt-repository ppa:webupd8team/java

apt-get install oracle-java8-installer

apt-get install system-config-kickstart

