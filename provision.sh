#Useful for user oracle
echo 'oracle  ALL=(ALL:ALL) ALL' >> /etc/sudoers
usermod -a -G vboxsf oracle

#Useful extra tools
yum -y update
yum -y install gparted
cd /software

#XE database
yum -y install oracle-rdbms-server-11gR2-preinstall
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
rpm -ivh oracle-xe-11.2.0-1.0.x86_64.rpm
/etc/init.d/oracle-xe configure responseFile=xe.rsp

#Java
yum -y remove java*
#yum -y localinstall jdk-8u151-linux-x64.rpm
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm
rpm -ivh jdk-8u151-linux-x64.rpm
alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

#WebLogic
unzip V886423-01.zip
java -jar fmw_12.2.1.3.0_wls.jar -silent -invPtrLoc `pwd`/inv.loc -responseFile `pwd`/wls.rsp

#unzip V886426-01.zip
