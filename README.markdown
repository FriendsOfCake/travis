[![Build Status](https://travis-ci.org/FriendsOfCake/travis.png?branch=master)](https://travis-ci.org/FriendsOfCake/travis)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE.txt)

# Easy travis setup for CakePHP plugins

This repository helps easy travis integration for CakePHP plugins, primarily focused on FriendsOfCake projects, but can be used within any plugin when satisfying the requirements.

## Description

Using this project for your CakePHP plugin will do the following:

 - Run the unit tests on travis-ci, for the defined matrix.
 - Run phpcs (PHP_CodeSniffer) on your plugin code to check for coding standards violations using the CakePHP standard
 - Uploads code coverage reports to codecov.io.

Make sure you have the travis webhook enabled in github for your plugin, and also add your repo to codecov.io

## Quick Install

We have provided a `setup.sh` shell script that should allow you to ensure conformity with the FriendsOfCake plugin standard. It should bypass a large part of the requirements mentioned here, as well as setup special files for later use. To use:

	cd path/to/your/repo

	# Clone this repo
	git clone https://github.com/FriendsOfCake/travis.git

	# Optionally set the plugin name, otherwise the current directory is used
	# export PLUGIN_NAME="YourPlugin"

	# Run the setup
	travis/setup.sh

	# Remove this repository when you are done
	rm -rf travis

The script will:

- Retrieve configuration specified

Please note that you can also use this for your own projects, and that you are free to update any of the files that have been templated out.

## Manual Instructions

- Copy the `templates/.travis.yml` file to the root of your project and rename it to `.travis.yml`
- Update in the global env variables in .travis.yml
  - Change `PLUGIN_NAME` to the camelcased name for a CakePHP plugin `PLUGIN_NAME=Example`
  - Optional: If you need some additional dependencies specific for testing only, you can add them in `REQUIRE`. The dependencies should be space separate and in composer format. Example: `REQUIRE="cakephp/debug_kit:2.2.* cakedc/search:dev-develop"`
- Optional: Further you could change build matrixes if needed. For instance when your tests also require other or no databases, or more or other CakePHP versions. By default database.php supports using mysql, postgres and sqlite, so you can add those to the matrix if required. For more info, see this [link](http://about.travis-ci.org/docs/user/languages/php/)
- Optional: If you need to use custom arguments for PHPCS (e.g. -n), you can add them in `PHPCS_ARGS`. If `PHPCS_ARGS` is specified it will override the defaults of `-p --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME`.
