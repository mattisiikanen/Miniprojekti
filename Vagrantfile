# -*- mode: ruby -*-
# vi: set ft=ruby :


# Commands that are run at the target machine, when called upon. Order for running the commands is from top to bottom.
$minion = <<MINION
sudo apt-get update
echo "master: 192.168.12.3">/etc/salt/minion
sudo service salt-minion restart
echo "See also: https://github.com/mattisiikanen/Miniprojekti"
MINION

$master = <<MASTER
sudo apt-get update
sudo apt-get -qy install git
sudo mkdir /srv/salt
sudo mkdir /srv/salt/readmes
sudo mkdir /srv/salt/win
sudo cp -R /vagrant/SLS/* /srv/salt/
sudo cp -R /vagrant/readmes/* /srv/salt/readmes
sudo chown root.salt /srv/salt/win
sudo chmod ug+rwx /srv/salt/win
sudo salt-run winrepo.update_git_repos
echo "See also: https://github.com/mattisiikanen/Miniprojekti"
MASTER

$wminion = <<MINION
Restart-Service -Name salt-minion
echo "See also: https://github.com/mattisiikanen/Miniprojekti"
MINION


# Define the ruleset used in Vagrant and the base VM box
Vagrant.configure("2") do |config|
config.vm.box = "debian/bullseye64"


# Define Linux VMs
	config.vm.define "lminion001" do |lminion001|
		lminion001.vm.network "private_network", ip: "192.168.12.100"
		lminion001.vm.hostname = "lminion001"
		lminion001.vm.provision :salt do |salt|
			salt.install_type = "stable"
		end
		lminion001.vm.provision :shell, inline: $minion
	end

	config.vm.define "lminion002" do |lminion002|
		lminion002.vm.network "private_network", ip: "192.168.12.102"
		lminion002.vm.hostname = "lminion002"
		lminion002.vm.provision :salt do |salt|
			salt.install_type = "stable"
		end
		lminion002.vm.provision :shell, inline: $minion
	end

	config.vm.define "mistermaster", primary: true do |mistermaster|
		mistermaster.vm.network "private_network", ip: "192.168.12.3"
		mistermaster.vm.hostname = "mistermaster"
		mistermaster.vm.provision :salt do |salt|
			salt.install_type = "stable"
			salt.install_master = true
		end
		mistermaster.vm.provision :shell, inline: $master
	end


# Define Windows VM
	config.vm.define "wminion001" do |wminion001|
		config.winrm.username = "vagrant"
		config.winrm.password = "vagrant"
		config.winrm.port = 25985
		
		wminion001.vm.box = "gusztavvargadr/windows-server-2022-standard"
		wminion001.vm.box_version = "2102.0.2304"
		wminion001.vm.network "private_network", ip: "192.168.12.103"
		wminion001.vm.guest = :windows
		wminion001.vm.host_name = "wminion001"
		wminion001.vm.network :forwarded_port, guest: 3389, host: 23389
		wminion001.vm.network :forwarded_port, guest: 5985, host: 25985
		wminion001.vm.provider "virtualbox" do |vb|
			vb.cpus = 4
			vb.memory = 8192
		end	
		wminion001.vm.provision :salt do |salt|
			salt.install_type = "stable"
			salt.minion_config = "config/wminion001"
		end
		wminion001.vm.provision "shell", privileged: "true", inline: $wminion
	end
end
