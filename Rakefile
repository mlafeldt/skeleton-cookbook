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
COOKBOOKS_PATH = ENV['COOKBOOKS_PATH'] || 'cookbooks'


task :setup_cookbooks do
  rm_rf COOKBOOKS_PATH
  sh 'berks', 'install', '--path', COOKBOOKS_PATH
end

desc 'Run knife cookbook test'
task :knife => :setup_cookbooks do
  sh 'knife', 'cookbook', 'test', COOKBOOK_NAME, '--config', '.knife.rb',
     '--cookbook-path', COOKBOOKS_PATH
end

desc 'Run Foodcritic lint checks'
task :foodcritic => :setup_cookbooks do
  sh 'foodcritic', '--epic-fail', 'any',
     File.join(COOKBOOKS_PATH, COOKBOOK_NAME)
end

desc 'Run ChefSpec examples'
task :chefspec => :setup_cookbooks do
  sh 'rspec', '--color', '--format', 'documentation',
     File.join(COOKBOOKS_PATH, COOKBOOK_NAME, 'spec')
end

desc 'Run all tests'
task :test => [:knife, :foodcritic, :chefspec]

task :default => :test

# aliases
task :lint => :foodcritic
task :spec => :chefspec
