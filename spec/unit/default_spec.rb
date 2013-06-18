require File.expand_path('../spec_helper', __FILE__)

describe 'The recipe skeleton::default' do
  let (:chef_run) do
    chef_run = ChefSpec::ChefRunner.new(
      :platform      => 'debian',
      :version       => '7.0',
      :log_level     => :error,
      :cookbook_path => COOKBOOK_PATH
    )
    Chef::Config.force_logger true
    chef_run.converge 'skeleton::default'
    chef_run
  end

  it 'installs sample package' do
    expect(chef_run).to install_package 'tree'
  end

  it 'does something' do
    pending 'Replace this with meaningful tests'
  end
end
