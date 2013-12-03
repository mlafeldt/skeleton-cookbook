require "spec_helper"

# Write unit tests with ChefSpec - http://sethvargo.com/chefspec/
describe "skeleton::default" do
  let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it "does something" do
    pending "Replace this with meaningful tests"
  end
end
