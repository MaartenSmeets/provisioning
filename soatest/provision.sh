
cd /software

#Docker
yum install yum-utils -y
yum-config-manager --enable ol7_addons
yum-config-manager --enable ol7_optional_latest
yum -y update
/usr/bin/ol_yum_configure.sh
yum -y update
yum install docker-engine -y
systemctl start docker
systemctl enable docker

#oracle user
groupadd oracle -g 1000
useradd -u 1000 -g 1000 -d /home/oracle -m oracle
echo -e "Welcome01\nWelcome01" | passwd oracle
usermod -a -G vboxsf oracle
usermod -a -G docker oracle
usermod --shell /bin/bash oracle
echo 'oracle  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

#Java
yum -y remove java*
wget -O /software/jdk.rpm -N --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.rpm
yum -y localinstall /software/jdk.rpm
alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

#Update this line and uncomment
docker login -u maarten.smeets@amis.nl -p XXXXX container-registry.oracle.com

mkdir -p /scratch/DockerVolume/SOAVolume/
chown 1000:1000 /scratch/DockerVolume/SOAVolume/
chmod 700 /scratch/DockerVolume/SOAVolume/
runuser -l oracle -c 'mkdir /scratch/DockerVolume/SOAVolume/SOA'

docker network create -d bridge SOANet

docker pull container-registry.oracle.com/database/enterprise:12.2.0.1
docker tag container-registry.oracle.com/database/enterprise:12.2.0.1 oracle/database:12.2.0.1-ee

#Execute below line to start the database
#docker run --name soadb --network=SOANet -p 1521:1521 -p 5500:5500 -v /scratch/DockerVolume/SOAVolume/DB:/opt/oracle/oradata --env-file /software/db.env.list  oracle/database:12.2.0.1-ee

docker pull container-registry.oracle.com/middleware/soasuite:12.2.1.3
docker tag container-registry.oracle.com/middleware/soasuite:12.2.1.3 oracle/soa:12.2.1.3


#The 2-container variant has issues -> no NodeManager running and AdminServer cannot manage Managed Server. The One container variant works
#
#Two containers
#docker run -i -t  --name soaas --network=SOANet -p 7001:7001 -v /scratch/DockerVolume/SOAVolume/SOA:/u01/oracle/user_projects --env-file /software/adminserver.env.list oracle/soa:12.2.1.3
#docker run -i -t  --name soams --network=SOANet -p 8001:8001 --volumes-from soaas --env-file /software/soaserver.env.list oracle/soa:12.2.1.3 "/u01/oracle/dockertools/startMS.sh"

#Fixing 2 container variant by connecting the containers and starting the nodemanager
#docker exec -u root soaas yum -y install socat
#docker exec -d -u root soaas "/usr/bin/socat" TCP4-LISTEN:8001,fork TCP4:soams:8001
#docker exec -d soaas "/u01/oracle/user_projects/domains/InfraDomain/bin/startNodeManager.sh"

#One container
#docker run -i -t  --name soaas --network=SOANet -p 7001:7001 -p 8001:8001 -v /scratch/DockerVolume/SOAVolume/SOA:/u01/oracle/user_projects --env-file /software/adminserver.env.list --env-file /software/soaserver.env.list oracle/soa:12.2.1.3
#docker exec -it soaas "/u01/oracle/dockertools/startMS.sh"
#docker exec -d soaas "/u01/oracle/user_projects/domains/InfraDomain/bin/startNodeManager.sh"

#For JDeveloper
#Build
#Files in software folder. Read Dockerfile for installers
#cd /media/sf_software
#docker build -t oracle/soa:12.2.1-dev .

#run
#docker run -i -t --name soajdev --network=SOANet -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix oracle/soa:12.2.1-dev "bash"
#docker exec -u root soajdev "yum" -y install libXext libXrender libXtst
#docker exec -u oracle soajdev "/u01/oracle/soa/jdeveloper/jdev/bin/jdev"