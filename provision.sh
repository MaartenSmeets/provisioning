yum -y install oracle-rdbms-server-11gR2-preinstall
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install gparted
cd /software
unzip -o oracle-xe-11.2.0-1.0.x86_64.rpm.zip
cd Disk1
rpm -ivh oracle-xe-11.2.0-1.0.x86_64.rpm
/etc/init.d/oracle-xe configure responseFile=../xe.rsp

