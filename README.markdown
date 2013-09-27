[![Build Status](https://travis-ci.org/FriendsOfCake/travis.png?branch=master)](https://travis-ci.org/FriendsOfCake/travis)

# Easy travis setup for CakePHP plugins

This repository helps easy travis integration for CakePHP plugins, primarily focused on FriendsOfCake projects, but can be used within any plugin when satisfying the requirements.

## Description

Using this project for your CakePHP plugin will do the following:

 - Run the unit tests on travis-ci, for the defined matrix.
 - Run phpcs (PHP_CodeSniffer) on your plugin code to check for coding standards violations using the CakePHP standard
 - Uploads code coverage reports to coveralls.io.

Make sure you have the travis webhook enabled in github for your plugin, and also add your repo to coveralls.io

## Quick Install

We have provided a `setup.sh` shell script that should allow you to ensure conformity with the FriendsOfCake plugin standard. It should bypass a large part of the requirements mentioned here, as well as setup special files for later use. To use:

	# example for Crud plugin

	cd path/to/app

	# Clone the repo down
	git clone vendor/travis

	# Export some environment variables for running the setup script
	export COPYRIGHT_YEAR=2011
	export GITHUB_USERNAME="friendsofcake"
	export PLUGIN_PATH="Plugin/YourPlugin"
	export PLUGIN_NAME="YourPlugin"
	export REPO_NAME="your-plugin"
	export YOUR_NAME="Christian Winthers"

	# Run the setup
	./vendor/travis/setup.sh

	# Remove this repository when you are done
	rm -rf vendor/travis

The following variables can be omitted and the script will attempt to guess their values:

- `GITHUB_USERNAME`: Retrieved from `git config --get github.user`
- `REPO_NAME`: Retrieved from `git remote -v`
- `YOUR_NAME`: Retrieved from `git config --get user.name'`

The script will:

- Retrieve configuration specified
- Template out files for submission to the **FriendsOfCake** organization, http://travis-ci.org, and http://packagist.org
- Template out othe rmissing fules, such as a `README.markdown` and an `AllPluginNameTest.php`
- Write a notice for signing up to http://coveralls.io

Please note that you can also use this for your own projects, and that you are free to update any of the files that have been templated out.

## Manual Instructions

- Copy the `templates/.travis.yml` file to the root of your project and rename it to `.travis.yml`
- Update in the global env variables in .travis.yml
  - Change `PLUGIN_NAME` to the camelcased name for a CakePHP plugin `PLUGIN_NAME=Example`
  - Optional: If your need some additional dependencies specific for testing only, you can add them in `REQUIRE`. The dependencies should be space separate and in composer format. Example: `REQUIRE="cakephp/debug_kit:2.2.* cakedc/search:dev-develop"`
- Optional: Further you could change build matrixes if needed. For instance when your tests also require other or no databases, or more or other CakePHP versions. By default database.php supports using mysql, postgres and sqlite, so you can add those to the matrix if required. For more info, see this [link](http://about.travis-ci.org/docs/user/languages/php/)

### Templates

Should you wish to manually setup a plugin, templates for the following files are available in the `templates` directory:

- `.editorconfig`
- `.semver`
- `.travis.yml`
- `.AllPluginNameTest.php`
- `composer.json`
- `CONTRIBUTING.markdown`
- `LICENSE.txt`
- `README.markdown`

Using the `setup.sh` script as described above will use these files as templates.

## Plugin Validation

Should you wish to validate a plugin, you can use the `validate.sh` shell script as follows:

	# example for Crud plugin

	cd path/to/app

	# Clone the repo down
	git clone vendor/travis

	# Export some environment variables for running the validate script
	export PLUGIN_PATH="Plugin/YourPlugin"

	# Run the setup
	./vendor/travis/validate.sh

	# Remove this repository when you are done
	rm -rf vendor/travis

Please note that this script will not fix any errors. To do so, please use the `setup.sh` shell script.

## License

The MIT License (MIT)

Copyright (c) 2013 FriendsOfCake

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
