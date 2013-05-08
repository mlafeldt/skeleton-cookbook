Testing
-------

This cookbook comes with everything you need to develop infrastructure code with
Chef and feel confident about it. The provided testing facilities allow you to
iterate quickly on cookbook changes.

After installing Vagrant and the required Ruby gems, most of the testing can be
done through convenient Rake tasks.

### Bundler

Apart from Vagrant, which is described later on, all tools you need for cookbook
development and testing are installed as Ruby gems using [Bundler]. This gives
you a lot of control over the software stack ensuring that the testing
environment matches your production environment.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gemset, for example:

    $ bundle exec rake

(You should keep `Gemfile.lock` checked in.)

### Rake

The cookbook provides a couple of helpful [Rake] tasks (specified in
`Rakefile`):

    $ rake -T
    rake clean                      # Remove any temporary products.
    rake clobber                    # Remove any generated file.
    rake test:all                   # Run test:syntax, test:lint, test:spec, and test:integration
    rake test:integration           # Run minitest integration tests with Vagrant
    rake test:integration_teardown  # Tear down VM used for integration tests
    rake test:lint                  # Run Foodcritic lint checks
    rake test:spec                  # Run ChefSpec examples
    rake test:syntax                # Run Knife syntax checks
    rake test:travis                # Run test:syntax, test:lint, and test:spec

As mentioned above, use `bundle exec` to start a Rake task:

    $ bundle exec rake test

The `test` task is an alias for `test:all` and also happens to be the default
when no task is given. All test-related tasks are described in more detail
below.

### Knife

The Rake task `test:syntax` will use `knife cookbook test` to run syntax checks
on the cookbook, validating both Ruby files and templates.

### Foodcritic

The Rake task `test:lint` will use [Foodcritic] to run lint checks on the
cookbook. Foodcritic is configured to fail if there are _any_ warnings that
might stop the cookbook from working.

### ChefSpec

The Rake task `test:spec` will run all [ChefSpec] examples in the `spec`
directory. Built on top of RSpec, ChefSpec allows you to write unit tests for
Chef cookbooks. It runs your cookbook - without actually converging a node - and
lets you make assertions about the resources that were created. This makes it
the ideal tool to get fast feedback on cookbook changes.

### Minitest

The Rake task `test:integration` will run minitest integration tests inside a VM
managed by Vagrant. This is done by adding the [minitest-handler cookbook] to
Chef's run list prior to provisioning the VM. This cookbook will install
[minitest-chef-handler] inside the VM, which in turn runs all
`files/**/*_test.rb` files at the end of the provisioning process.

In case the VM is powered off, `rake test:integration` will boot it up first.
When you no longer need the VM for integration testing, `rake
test:integration_teardown` will shut it down. If you rather want to provision
from scratch, set `INTEGRATION_TEARDOWN` accordingly. For example:

    $ export INTEGRATION_TEARDOWN='vagrant destroy -f'
    $ rake test:integration_teardown
    $ rake test:integration

### Berkshelf

[Berkshelf] is used to set up the cookbook and its dependencies prior to testing
with Rake and Vagrant.

The dependencies are defined in `Berksfile`, which in turn resolves the
dependencies in `metadata.rb`. It is good practice to specify the cookbook
sources in `Berksfile`, while keeping the cookbook versions in `metadata.rb`
(the authoritative source of information for Chef).

During testing, dependencies are installed to the `fixtures` directory inside
this cookbook.

### Vagrant

With [Vagrant], you can spin up a virtual machine and run your cookbook inside
it via Chef Solo or Chef Client. The test setup requires to install **Vagrant
1.2.x** from the [Vagrant downloads page].

You will also need the [vagrant-berkshelf] plugin, which will make your cookbook
and its dependencies automatically available to Vagrant when creating or
provisioning a VM:

    $ vagrant plugin install vagrant-berkshelf

When everything is in place, this command will boot and provision the VM as
specified in the `Vagrantfile`:

    $ vagrant up

In case the VM is already up, you can run the provisioners again with:

    $ vagrant provision

### Travis CI

The cookbook includes a configuration for [Travis CI] that will run `rake
test:travis` each time changes are pushed to GitHub. Simply enable Travis for
your GitHub repository to get free continuous integration.

Implementing CI with other systems should be as simple as running the commands
in `.travis.yml`.


[Berkshelf]: http://berkshelf.com
[Bundler]: http://gembundler.com
[ChefSpec]: https://github.com/acrmp/chefspec
[Foodcritic]: http://acrmp.github.com/foodcritic/
[Rake]: http://rake.rubyforge.org
[Travis CI]: https://travis-ci.org
[Vagrant downloads page]: http://downloads.vagrantup.com/
[Vagrant]: http://vagrantup.com
[minitest-chef-handler]: https://github.com/calavera/minitest-chef-handler
[minitest-handler cookbook]: https://github.com/btm/minitest-handler-cookbook
[vagrant-berkshelf]: https://github.com/RiotGames/vagrant-berkshelf
