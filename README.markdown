# Easy travis setup for CakePHP plugins

This repository helps easy travis integration for CakePHP plugins, primarily
focused on FriendsOfCake projects, but can be used within any plugin when
satisfying the requirements.

## Description

Previously travis required quite some configuration to set up CakePHP 2.x
plugins. With CakePHP 3.0 using composer for installation and phpunit commands
instead of a Cake Test Shell all the previously included goodies are no longer
needed. All that is needed to set up testing on travis for your plugin is the included travis file

Using the travis file from the templates folder it will do the following on
travis-ci.org:
 - Run the unit tests on travis-ci, for the defined matrix.
 - Run phpcs (PHP_CodeSniffer) on your plugin code to check for coding
   standards violations using the CakePHP standard
 - Uploads code coverage reports to coveralls.io.

Make sure you have the travis webhook enabled in github for your plugin, and
also add your repo to coveralls.io

## Instructions

- Copy the `templates/.travis.yml` file to the root of your project and rename
  it to `.travis.yml`
- Optional: You could change the build matrix if needed. For instance when your
  tests also require other/no databases or other php versions.
  By default tests are run on mysql, postgres and sqlite, you can change those
  in the matrix if required. For more info, see this
  [link](http://about.travis-ci.org/docs/user/languages/php/)
