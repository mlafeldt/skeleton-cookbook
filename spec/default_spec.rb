require "spec_helper"

describe "skeleton::default" do
  let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it "installs sample package" do
    expect(chef_run).to install_package "tree"
  end

  it "does something" do
    pending "Replace this with meaningful tests"
  end
end
