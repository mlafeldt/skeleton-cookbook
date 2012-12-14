Description
===========

A skeleton Chef cookbook with a focus on testability. See chapter "Testing" to
learn more.

Fork the repository, adapt it to your needs, and use it as a starting point for
new cookbooks.

Requirements
============

## Platform:

* Ubuntu
* Debian

## Cookbooks:

*No dependencies defined*

Attributes
==========

*No attributes defined*

Recipes
=======

## skeleton::default

Installs/configures something

Testing
=======

The cookbook comes with some testing facilities allowing you to iterate quickly.

Rake
----

You can execute the tests with [Rake](http://rake.rubyforge.org). The `Rakefile`
provides the following tasks:

    $ rake -T
    rake chefspec    # Run ChefSpec examples
    rake foodcritic  # Run Foodcritic lint checks
    rake knife       # Run knife cookbook test
    rake test        # Run all tests

Bundler
-------

If you prefer to let [Bundler](http://gembundler.com) install all required gems
(you should), run the tests this way:

    $ bundle install
    $ bundle exec rake test

Berkshelf
---------

[Berkshelf](http://berkshelf.com) is used to install the cookbook's dependencies
(as defined in `Berksfile`) prior to testing with Rake and Vagrant.

Vagrant
-------

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run
your cookbook via Chef Solo. This will boot the VM:

    $ bundle exec vagrant up

Travis CI
---------

The cookbook includes a configuration for [Travis CI](https://travis-ci.org).
Simply enable Travis for your GitHub repository to get free continuous
integration.

License and Author
==================

Author:: YOUR_NAME (<YOUR_NAME@bigpoint.net>)

Copyright:: 2012, Bigpoint GmbH

License:: All rights reserved
