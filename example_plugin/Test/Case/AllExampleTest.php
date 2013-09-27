<?php
/**
 * All tests for Example plugin
 *
 */
class AllExampleTest extends CakeTestCase {

/**
 * Suite defines all the tests for Example plugin
 *
 * @return CakeTestSuite
 */
	public static function suite() {
		$suite = new CakeTestSuite('All Example tests');
		$suite->addTestDirectoryRecursive(dirname(__FILE__));

		return $suite;
	}
}
