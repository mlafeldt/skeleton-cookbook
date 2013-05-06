# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.hostname = 'skeleton-ubuntu'

  # Enable Berkshelf plugin which will make cookbooks available to Vagrant
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'minitest-handler' unless ENV['INTEGRATION_TEST'].nil?
    chef.add_recipe 'apt'
    chef.add_recipe 'skeleton'

    chef.json = {
      # Only run integration tests for this cookbook, and save CI reports
      "minitest" => {
        "tests" => "skeleton/*_test.rb",
        "ci_reports" => "/var/chef/ci_reports"
      }
    }

    chef.log_level = :debug
  end
end
