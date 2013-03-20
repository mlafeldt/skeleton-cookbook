Description
===========

This is a testable skeleton cookbook designed for you or your organization to
fork and modify appropriately. The cookbook comes with everything you need to
develop infrastructure code with Chef and feel confident about it. See chapter
**Testing** to learn more.

(While you're encouraged to customize everything in this cookbook to fit your
needs, I recommend to keep the Testing chapter as an important part of this
README.)

Requirements
============

## Platform:

*List supported platforms here*

## Cookbooks:

*List cookbook dependencies here*

Attributes
==========

*List attributes here*

Recipes
=======

## skeleton::default

Installs/configures something

Testing
=======

The cookbook comes with some testing facilities allowing you to iterate quickly
on cookbook changes. After installing Vagrant and the required Ruby gems, most
of the testing can be done through convenient Rake tasks.

## Bundler

Apart from Vagrant, which is described later on, all tools you need for cookbook
development and testing are installed as Ruby gems using [Bundler](http://gembundler.com).
This gives you a lot of control over the software stack ensuring that the
testing environment matches your production environment.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gemset, for example:

    $ bundle exec rake

(You should keep `Gemfile.lock` checked in.)

## Rake

The cookbook provides a couple of helpful [Rake](http://rake.rubyforge.org)
tasks (specified in `Rakefile`):

    $ rake -T
    rake clean                      # Remove any temporary products.
    rake clobber                    # Remove any generated file.
    rake test:all                   # Run test:syntax, test:lint, test:spec, and test:integration
    rake test:integration           # Run minitest integration tests with Vagrant
    rake test:integration_teardown  # Tear down VM used for integration tests
    rake test:lint                  # Run Foodcritic lint checks
    rake test:spec                  # Run ChefSpec examples
    rake test:syntax                # Run Knife syntax checks

As mentioned above, use `bundle exec` to start a Rake task:

    $ bundle exec rake test

The `test` task is an alias for `test:all` and also happens to be the default
when no task is given. All test-related tasks are described in more detail
below.

## Knife

The Rake task `test:syntax` will use `knife cookbook test` to run syntax checks
on the cookbook, validating both Ruby files and templates.

## Foodcritic

The Rake task `test:lint` will use [Foodcritic](http://acrmp.github.com/foodcritic/)
to run lint checks on the cookbook. Foodcritic is configured to fail if there
are _any_ warnings that might stop the cookbook from working.

## ChefSpec

The Rake task `test:spec` will run all [ChefSpec](https://github.com/acrmp/chefspec)
examples in the `spec` directory. Built on top of RSpec, ChefSpec allows you to
write unit tests for Chef cookbooks. It runs your cookbook - without actually
converging a node - and lets you make assertions about the resources that were
created. This makes it the ideal tool to get fast feedback on cookbook changes.

## Berkshelf

[Berkshelf](http://berkshelf.com) is used to set up the cookbook and its
dependencies prior to testing with Rake and Vagrant.

The dependencies are defined in `Berksfile`, which in turn resolves the
dependencies in `metadata.rb`. It is good practice to specify the cookbook
sources in `Berksfile`, while keeping the cookbook versions in `metadata.rb`
(the authoritative source of information for Chef).

During testing, dependencies are installed to the `cookbooks` directory inside
this cookbook.

## Vagrant

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run
your cookbook inside it via Chef Solo or Chef Client. The test setup requires to
install **Vagrant 1.1.x** from the [Vagrant downloads page](http://downloads.vagrantup.com/).

You will also need the Berkshelf Vagrant plugin, which will make your cookbook
and its dependencies automatically available to Vagrant when creating or
provisioning a VM:

    $ vagrant plugin install berkshelf-vagrant

When everything is in place, this command will boot and provision the VM as
specified in the `Vagrantfile`:

    $ vagrant up

In case the VM is already up, you can run the provisioners again with:

    $ vagrant provision

## Travis CI

The cookbook includes a configuration for [Travis CI](https://travis-ci.org) that
will run `rake test` each time changes are pushed to GitHub. Simply enable Travis
for your GitHub repository to get free continuous integration.

[![Build Status](https://travis-ci.org/mlafeldt/skeleton-cookbook.png?branch=master)](https://travis-ci.org/mlafeldt/skeleton-cookbook)

Implementing CI with other systems should be as simple as running the commands
in `.travis.yml`.

License and Author
==================

Author:: Mathias Lafeldt (<mathias.lafeldt@gmail.com>)

Copyright:: 2013, Mathias Lafeldt

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
