#
# Rake tasks to test your cookbook
#
# Copyright (C) 2012-2013 Mathias Lafeldt <mathias.lafeldt@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/cookbook/metadata'
require 'rake/clean'
require 'rspec/core/rake_task'

def cookbook_metadata
  metadata = Chef::Cookbook::Metadata.new
  metadata.from_file 'metadata.rb'
  metadata
end

def cookbook_name
  name = cookbook_metadata.name
  if name.nil? || name.empty?
    File.basename(File.dirname(__FILE__))
  else
    name
  end
end

COOKBOOK_NAME = ENV.fetch('COOKBOOK_NAME', cookbook_name)
COOKBOOK_PATH = ENV.fetch('COOKBOOK_PATH', 'vendor/cookbooks')

CLOBBER.include COOKBOOK_PATH, 'Berksfile.lock', '.kitchen', '.vagrant'

desc 'Display information about the environment'
task :env do
  {
    :ruby              => 'ruby --version',
    :rubygems          => 'gem --version',
    :bundler           => 'bundle --version',
    :vagrant           => 'vagrant --version',
    :vagrant_berkshelf => 'vagrant plugin list 2>/dev/null | grep berkshelf',
    :virtualbox        => 'VBoxManage --version'
  }.each do |key, cmd|
    begin
      result = `#{cmd}`.chomp
    rescue Errno::ENOENT
      result = 'not found'
    end
    puts "  * #{key}: #{result}"
  end
end

namespace :test do
  task :prepare do
    ENV['COOKBOOK_PATH'] = COOKBOOK_PATH
    sh 'berks', 'install', '--path', COOKBOOK_PATH
    # Run cleanup at exit unless an exception was raised.
    at_exit { Rake::Task['test:cleanup'].invoke if $!.nil? }
  end

  task :cleanup do
    rm_rf COOKBOOK_PATH
  end

  desc 'Run Knife syntax checks'
  task :syntax => :prepare do
    sh 'knife', 'cookbook', 'test', COOKBOOK_NAME, '--config', '.knife.rb',
       '--cookbook-path', COOKBOOK_PATH
  end

  desc 'Run Foodcritic lint checks'
  task :lint => :prepare do
    # TODO: FoodCritic::Rake::LintTask is still experimental
    sh 'foodcritic', '--epic-fail', 'any',
       File.join(COOKBOOK_PATH, COOKBOOK_NAME)
  end

  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/*_spec.rb'
    t.rspec_opts = '--color --format documentation'
  end
  task :unit => :prepare

  desc 'Run serverspec integration tests with Vagrant'
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = 'spec/integration/**/*_spec.rb'
    t.rspec_opts = '--color --format documentation'
  end
  task :integration => 'vagrant:provision'

  desc 'Tear down VM used for integration tests'
  task :integration_teardown do
    # Shut VM down unless INTEGRATION_TEARDOWN is set to a different task.
    Rake::Task[ENV.fetch('INTEGRATION_TEARDOWN', 'vagrant:halt')].invoke
  end

  desc 'Run test:syntax, test:lint, and test:unit'
  task :travis => [:syntax, :lint, :unit]

  desc 'Run test:syntax, test:lint, test:unit, and test:integration'
  task :all => [:syntax, :lint, :unit, :integration, :integration_teardown]
end

namespace :vagrant do
  desc 'Provision the VM using Chef'
  task :provision do
    # Provision VM depending on its state.
    case `vagrant status`
    when /The VM is running/ then ['provision']
    when /To resume this VM/ then ['up', 'provision']
    else ['up']
    end.each { |cmd| sh 'vagrant', cmd }
  end

  desc 'SSH into the VM'
  task :ssh do
    sh 'vagrant', 'ssh'
  end

  desc 'Shutdown the VM'
  task :halt do
    sh 'vagrant', 'halt', '--force'
  end

  desc 'Destroy the VM'
  task :destroy do
    sh 'vagrant', 'destroy', '--force'
    Rake::Task['test:cleanup'].invoke
  end
end

# Aliases for backwards compatibility and convenience
task :lint => 'test:lint'
task :spec => 'test:unit'
task :test => 'test:all'

task :default => :test
