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

#Java
yum -y remove java*
wget -O /software/jdk-8u171-linux-x64.rpm -N --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm
yum -y localinstall /software/jdk-8u171-linux-x64.rpm
alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

#docker login -u maarten.smeets@amis.nl -p xxxxx container-registry.oracle.com

mkdir -p /scratch/DockerVolume/SOAVolume/
chown 1000:1000 /scratch/DockerVolume/SOAVolume/
chmod 700 /scratch/DockerVolume/SOAVolume/
runuser -l oracle -c 'mkdir /scratch/DockerVolume/SOAVolume/SOA'

docker network create -d bridge SOANet

docker pull container-registry.oracle.com/database/enterprise:12.2.0.1
docker tag container-registry.oracle.com/database/enterprise:12.2.0.1 oracle/database:12.2.0.1-ee
docker run --name soadb --network=SOANet -p 1521:1521 -p 5500:5500 -v /scratch/DockerVolume/SOAVolume/DB:/opt/oracle/oradata --env-file /software/db.env.list  oracle/database:12.2.0.1-ee

docker pull container-registry.oracle.com/middleware/soasuite:12.2.1.3
docker tag container-registry.oracle.com/middleware/soasuite:12.2.1.3 oracle/soa:12.2.1.3

#Two containers
#docker run -i -t  --name soaas --network=SOANet -p 7001:7001 -v /scratch/DockerVolume/SOAVolume/SOA:/u01/oracle/user_projects --env-file /software/adminserver.env.list oracle/soa:12.2.1.3
#docker run -i -t  --name soams --network=SOANet -p 8001:8001 --volumes-from soaas --env-file /software/soaserver.env.list oracle/soa:12.2.1.3 "/u01/oracle/dockertools/startMS.sh"

#One container
#docker run -i -t  --name soaas --network=SOANet -p 7001:7001 -p 8001:8001 -v /scratch/DockerVolume/SOAVolume/SOA:/u01/oracle/user_projects --env-file /software/adminserver.env.list --env-file /software/soaserver.env.list oracle/soa:12.2.1.3
#docker exec -it soaas "/u01/oracle/dockertools/startMS.sh"
#docker exec -d soaas "/u01/oracle/user_projects/domains/InfraDomain/bin/startNodeManager.sh"

#Below is 'old fashioned'

#WebLogic
#runuser -l oracle -c 'unzip -o /software/V886423-01.zip -d /software'
#runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_wls.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/wls.rsp'

#SOA Infrastructure
#runuser -l oracle -c 'unzip -o /software/V886426-01.zip -d /software'
#runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_infrastructure.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/wls_infra.rsp'

#SOA Suite
#runuser -l oracle -c 'unzip -o /software/V886440-01.zip -d /software'
#runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_soa.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/soa.rsp'

#OSB
#runuser -l oracle -c 'unzip -o /software/V886445-01.zip -d /software'
#runuser -l oracle -c 'java -jar /software/fmw_12.2.1.3.0_osb.jar -silent -invPtrLoc /software/inv.loc -responseFile /software/osb.rsp'

#RCU
#runuser -l oracle -c '/home/oracle/Oracle/Middleware1221/oracle_common/bin/rcu -silent -responseFile /software/rcuResponseFile.properties'
