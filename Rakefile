# encoding: utf-8
require "foodcritic"
require "rspec/core/rake_task"

desc "Run Foodcritic lint checks"
FoodCritic::Rake::LintTask.new(:lint) do |t|
  t.options = { :fail_tags => ["any"] }
end

desc "Run ChefSpec examples"
RSpec::Core::RakeTask.new(:spec)

desc "Run all tests"
task :test => [:lint, :spec, :tailor, :taste, :rubocop]
task :default => :test

desc "Run tailor tests"
task :tailor do
  sh 'bundle exec tailor *.rb ./**/*.rb ./**/**/**/**/*.rb'
end

desc "Run taste tests"
task :taste do
  sh 'bundle exec taste'
end

desc "Run rubocop tests"
task :rubocop do
  sh 'bundle exec rubocop'
end

begin
  require "kitchen/rake_tasks"
  Kitchen::RakeTasks.new

  desc "Alias for kitchen:all"
  task :integration => "kitchen:all"

  task :test => :integration
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
