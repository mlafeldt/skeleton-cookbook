require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(SpecInfra::Command::Base).check_os
    c.path = "/sbin:/usr/sbin"
  end
end
