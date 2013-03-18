Description
===========

This is a testable skeleton cookbook designed for you or your organization to
fork and modify appropriately. The cookbook comes with everything you need to
develop infrastructure code with Chef and feel confident about it. See chapter
**Testing** to learn more.

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
on cookbook changes. After installing the required Ruby gems with Bundler, most
of the testing can be done through convenient Rake tasks.

## Bundler

All tools you need for cookbook development are installed as Ruby gems using
[Bundler](http://gembundler.com). This gives you complete control over your
software stack and makes sure that, for example, you're using the same version
of Chef for testing as in production.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gems, for example:

    $ bundle exec rake

(You should keep `Gemfile.lock` checked in.)

## Rake

The cookbook provides a couple of helpful [Rake](http://rake.rubyforge.org)
tasks (specified in `Rakefile`):

    $ rake -T
    rake clean        # Remove any temporary products.
    rake clobber      # Remove any generated file.
    rake test         # Run all tests
    rake test:lint    # Run Foodcritic lint checks
    rake test:spec    # Run ChefSpec examples
    rake test:syntax  # Run Knife syntax checks

As mentioned above, use `bundle exec` to start a Rake task:

    $ bundle exec rake test

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
your cookbook inside it via Chef Solo.

This command will boot and provision the VM as specified in the `Vagrantfile`:

    $ bundle exec vagrant up

(Berkshelf's Vagrant plugin will make your cookbook and its dependencies
automatically available to Vagrant when creating or provisioning a VM.)

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
