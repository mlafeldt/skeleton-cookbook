require 'chefspec'

describe 'The recipe skeleton::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'skeleton::default' }

  it 'should do something' do
    pending 'Add recipe examples here'
  end
end
