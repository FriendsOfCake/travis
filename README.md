# Easy travis setup for CakePHP plugins

## About

This repository helps easy travis integration for CakePHP plugins, primarily
focussed on FriendsOfCake projects, but can be used within any plugin when
satisfying the requirements.

## Instructions

- Copy the `.travis.example.yml` file to the root of your project and rename it
to `.travis.yml`
- Update in the global env variables in .travis.yml
  - Change `REPO_NAME` to match the github project name
  - Change `PLUGIN_NAME` to the camelcased name for a CakePHP plugin
  - Optional: If your need some additional dependencies specific for testing only,
you can add them in `REQUIRE`. The dependencies should be space separate and in
composer format. Example: `cakephp/debug_kit:2.2.* cakedc/search:dev-develop`
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
