require 'minitest/spec'

describe_recipe 'skeleton::default' do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  # Add meaningful tests here
  it 'should create the folder /var/chef/minitest/skeleton' do
    directory('/var/chef/minitest/skeleton').must_exist
  end
end
