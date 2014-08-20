# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def setup_chef_solo(config, &block)
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.cookbooks_path = ['./cookbooks', './site-cookbooks']
    yield(chef) if block_given?
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/centos-6.5"
  config.vm.network "private_network", ip: "192.168.33.50"
  config.vm.hostname = 'golang'

  config.omnibus.chef_version = :latest
  setup_chef_solo(config) do |chef|
    chef.add_recipe "recipe[golang::default]"
    chef.json = {
    }
  end
end
