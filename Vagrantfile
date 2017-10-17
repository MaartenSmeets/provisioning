# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "soadb" , primary: true do |soadb|
  #for remote (uses vagrantcloud)
  soadb.vm.box = "maartensmeets/oel74"
  soadb.vm.box_version = "0.0.1"
	
  #for local
  #soadb.vm.box = "ol74"
  soadb.vm.hostname = "soadb"
    
  #update this folder. it should contain oracle-xe-11.2.0-1.0.x86_64.rpm.zip and xe.rsp
  soadb.vm.synced_folder "d:/vagrant/software", "/software", :mount_options => ["dmode=777","fmode=777"]

  soadb.vm.network :private_network, ip: "192.168.0.1"

  soadb.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm"     , :id, "--memory", "4096"]
      vb.customize ["modifyvm"     , :id, "--name"  , "soadb"]
      vb.customize ["modifyvm"     , :id, "--cpus"  , 4]
  end
	
  #this starts provisioning the machine
  soadb.vm.provision :shell, path: "provision.sh"

  end

end
