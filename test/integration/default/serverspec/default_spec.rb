require "spec_helper"

describe "skeleton::default" do
  it "installs sample package" do
    expect(package "tree").to be_installed
  end

  it "does something" do
    pending "Replace this with meaningful tests"
  end
end
