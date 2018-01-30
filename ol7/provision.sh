#Useful for user oracle
#Already present in provided Packer template
#echo 'oracle  ALL=(ALL:ALL) ALL' >> /etc/sudoers
usermod -a -G vboxsf oracle

#yum -y update
cd /software

#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#rpm -ivh epel-release-latest-7.noarch.rpm
#yum -y install gparted

#Docker
yum-config-manager --enable ol7_addons
yum-config-manager --enable ol7_optional_latest
yum install docker-engine btrfs-progs btrfs-progs-devel -y
systemctl start docker
systemctl enable docker
usermod -a -G docker oracle
docker login -u maarten.smeets@amis.nl -p WdKw2doNuff8N container-registry.oracle.com

#Database
docker run -d --env-file /software/db_env.dat -p 1521:1521 -p 5500:5500 -it --name dockerDB container-registry.oracle.com/database/enterprise:12.2.0.1-slim

#Java
yum -y remove java*
wget -O /software/jdk-8u151-linux-x64.rpm -N --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm
yum -y localinstall /software/jdk-8u151-linux-x64.rpm
alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

#WebLogic
runuser -l oracle -c 'unzip -o /software/V886423-01.zip -d /software'
runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_wls.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/wls.rsp'

#SOA Infrastructure
runuser -l oracle -c 'unzip -o /software/V886426-01.zip -d /software'
runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_infrastructure.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/wls_infra.rsp'

#SOA Suite
runuser -l oracle -c 'unzip -o /software/V886440-01.zip -d /software'
runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_soa.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/soa.rsp'

#OSB
runuser -l oracle -c 'unzip -o /software/V886445-01.zip -d /software'
runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_osb.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/osb.rsp'

#RCU
runuser -l oracle -c '/home/oracle/Oracle/Middleware1221/oracle_common/bin/rcu -silent -responseFile /software/rcuResponseFile.properties'
