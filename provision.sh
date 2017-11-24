#Useful for user oracle
#Already present in provided Packer template
#echo 'oracle  ALL=(ALL:ALL) ALL' >> /etc/sudoers
usermod -a -G vboxsf oracle

yum -y update
cd /software

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install gparted



#Java
yum -y remove java*
#yum -y localinstall jdk-8u151-linux-x64.rpm
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm
rpm -ivh jdk-8u151-linux-x64.rpm
alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

#Database
#rpm -ivh oracle-xe-11.2.0-1.0.x86_64.rpm
#/etc/init.d/oracle-xe configure responseFile=xe.rsp
yum -y install oracle-database-server-12cR2-preinstall
sed -i '1s/^/192.168.3.2 soadb\n/' /etc/hosts

unzip -o linuxx64_12201_database.zip
runuser -l oracle -c '/software/database/runInstaller -waitforcompletion -silent -invPtrLoc /software/inv.loc -responseFile /software/db.rsp'
printf '\n\n' | /home/oracle/app/oracle/product/12.2.0/dbhome_1/root.sh

runuser -l oracle -c '/software/database/runInstaller -executeConfigTools -waitforcompletion -silent -invPtrLoc /software/inv.loc -responseFile /software/db.rsp'

sed -i 's/dbhome_1:N/dbhome_1:Y/g' /etc/oratab
#ORCL:/home/oracle/app/oracle/product/12.2.0/dbhome_1:Y in /etc/oratab

#create dbora script
cp /software/dbora /etc/init.d
chmod 750 dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc0.d/K01dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/S99dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/S99dbora

#WebLogic
unzip -o V886423-01.zip
java -jar fmw_12.2.1.3.0_wls.jar -silent -invPtrLoc `pwd`/inv.loc -responseFile `pwd`/wls.rsp

#SOA Infrastructure
unzip -o V886426-01.zip
java -jar fmw_12.2.1.3.0_infrastructure.jar -silent -invPtrLoc `pwd`/inv.loc -responseFile `pwd`/wls_infra.rsp

#SOA Suite
unzip -o V886440-01.zip
java -jar fmw_12.2.1.3.0_soa.jar -silent -invPtrLoc `pwd`/inv.loc -responseFile `pwd`/soa.rsp

#OSB
unzip -o V886445-01.zip
java -jar fmw_12.2.1.3.0_osb.jar -silent -invPtrLoc `pwd`/inv.loc -responseFile `pwd`/osb.rsp

#RCU
/home/oracle/Oracle/Middleware1221/oracle_common/bin/rcu -silent -responseFile `pwd`/rcuResponseFile.properties
