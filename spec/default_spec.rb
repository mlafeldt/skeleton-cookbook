require 'chefspec'

describe 'The recipe skeleton::default' do
  let (:chef_run) do
    chef_run = ChefSpec::ChefRunner.new(:platform => 'debian', :version => '7.0')
    chef_run.converge 'skeleton::default'
    chef_run
  end

  it 'converges' do
    expect(chef_run).to be
  end

  it 'does something' do
    pending 'Add recipe examples here'
  end
end
