<?php
/**
 * All PLUGIN_NAME plugin tests
 */
class AllPLUGIN_NAMETest extends CakeTestCase {

/**
 * Suite define the tests for this suite
 *
 * @return void
 */
	public static function suite() {
		$suite = new CakeTestSuite('All PLUGIN_NAME test');

		$path = CakePlugin::path('PLUGIN_NAME') . 'Test' . DS . 'Case' . DS;
		$suite->addTestDirectoryRecursive($path);

		return $suite;
	}

}
