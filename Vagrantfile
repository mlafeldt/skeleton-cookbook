# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "skeleton-ubuntu"

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'minitest-handler' unless ENV['INTEGRATION_TEST'].nil?
    chef.add_recipe 'apt'
    chef.add_recipe 'skeleton'

    chef.json = {}
    chef.log_level = :debug
  end
end
