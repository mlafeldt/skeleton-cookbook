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

COOKBOOK_NAME = ENV['COOKBOOK_NAME'] || cookbook_name
FIXTURES_PATH = ENV['FIXTURES_PATH'] || 'fixtures'

CLOBBER.include FIXTURES_PATH, 'Berksfile.lock', '.vagrant'

namespace :test do
  task :prepare do
    sh 'berks', 'install', '--path', FIXTURES_PATH
    # Run cleanup at exit unless an exception was raised.
    at_exit { Rake::Task['test:cleanup'].invoke if $!.nil? }
  end

  task :cleanup do
    rm_rf FIXTURES_PATH
  end

  desc 'Run Knife syntax checks'
  task :syntax => :prepare do
    sh 'knife', 'cookbook', 'test', COOKBOOK_NAME, '--config', '.knife.rb',
       '--cookbook-path', FIXTURES_PATH
  end

  desc 'Run Foodcritic lint checks'
  task :lint => :prepare do
    # TODO: FoodCritic::Rake::LintTask is still experimental
    sh 'foodcritic', '--epic-fail', 'any',
       File.join(FIXTURES_PATH, COOKBOOK_NAME)
  end

  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = File.join(FIXTURES_PATH, COOKBOOK_NAME, 'spec', '*_spec.rb')
    t.rspec_opts = '--color --format documentation'
  end
  task :spec => :prepare

  desc 'Run minitest integration tests with Vagrant'
  task :integration do
    # This variable is evaluated by Berksfile and Vagrantfile, and will add
    # minitest-handler to Chef's run list.
    ENV['INTEGRATION_TEST'] = '1'

    # Provision VM depending on its state.
    case `vagrant status`
    when /The VM is running/ then ['provision']
    when /To resume this VM/ then ['up', 'provision']
    else ['up']
    end.each { |cmd| sh 'vagrant', cmd }
  end

  desc 'Tear down VM used for integration tests'
  task :integration_teardown do
    # Shut VM down unless INTEGRATION_TEARDOWN is set to a different command.
    sh ENV.fetch('INTEGRATION_TEARDOWN', 'vagrant halt --force')
  end

  desc 'Run test:syntax, test:lint, and test:spec'
  task :travis => [:syntax, :lint, :spec]

  desc 'Run test:syntax, test:lint, test:spec, and test:integration'
  task :all => [:syntax, :lint, :spec, :integration, :integration_teardown]
end

# Aliases for backwards compatibility and convenience
task :test => 'test:all'
task :spec => 'test:spec'

task :default => :test
