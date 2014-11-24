require "serverspec"

set :backend, :ssh
set :path, "/sbin:/usr/sbin:$PATH"
