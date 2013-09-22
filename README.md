# Easy travis setup for CakePHP plugins

## About

This repository helps easy travis integration for CakePHP plugins, primarily
focussed on FriendsOfCake projects, but can be used within any plugin when
satisfying the requirements.

## Instructions

- Copy the `.travis.example.yml` file to the root of your project and rename it
to `.travis.yml`
- Update in the global env variables in .travis.yml
  - Change `PLUGIN_NAME` to the camelcased name for a CakePHP plugin `PLUGIN_NAME=Example`
  - Optional: If your need some additional dependencies specific for testing only,
you can add them in `REQUIRE`. The dependencies should be space separate and in
composer format. Example: `REQUIRE="cakephp/debug_kit:2.2.* cakedc/search:dev-develop"`
- Optional: Further you could change build matrixes if needed. For instance when
your tests also require other or no databases, or more or other CakePHP versions.
By default database.php supports using mysql, postgres and sqlite, so you can
add those to the matrix if required.
More info: http://about.travis-ci.org/docs/user/languages/php/

## Requirements

- Your plugin should have AllPluginNameTest.php to run all your plugin tests
- Your plugin should have a composer.json (FoC requirement already)

### Example file for AllExampleTest.php

This is what a file would look like for the Example plugin (in `Test/Case/All${plugin}Test.php`)

```php
<?php
/**
 * All tests for this plugin
 *
 */
class AllExampleTest extends CakeTestCase {

/**
 * Suite define the tests for this suite
 *
 * @return CakeTestSuite
 */
	public static function suite() {
		$suite = new CakeTestSuite('All Example tests');

		$path = CakePlugin::path('Example') . 'Test' . DS . 'Case' . DS;
		$suite->addTestDirectoryRecursive($path);

		return $suite;
	}
}
```

### Example file for composer.json

This is what the composer.json file would look like for Example plugin

```json
{
    "name": "friendsofcake/example",
    "type": "cakephp-plugin",
    "description": "Example plugin for travis",
    "keywords":[
        "cakephp",
        "example",
        "travis"
    ],
    "homepage": "http://github.com/FriendsOfCake/example",
    "authors":[
        {
            "name":"",
            "role":"Author"
        }
    ],
    "license": "MIT",
    "support":{
        "source":"https://github.com/FriendsOfCake/Example",
        "issues":"https://github.com/FriendsOfCake/Example/issues",
        "irc":"irc://irc.freenode.org/friendsofcake"
    },
    "require": {
        "php": ">=5.3.0",
        "composer/installers": "*"
    },
    "extra": {
        "installer-name": "Example"
    }
}
```

You can also create a composer.json file by running the following command: `composer init` in the root of the plugin

## What does it do

Using this project for your CakePHP plugin will do the following:
 - Run the unit tests on travis-ci, for the defined matrix.
 - Run phpcs (PHP_CodeSniffer) on your plugin code to check for coding standards violations using the CakePHP standard
 - Uploads code coverage reports to coveralls.io.

Make sure you have the travis webhook enabled in github for your plugin, and also add your repo to coveralls.io
