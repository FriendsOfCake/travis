<?php

class PostTest extends CakeTestCase {

	public $fixtures = array('post');

	public function testGetAll() {
		$Model = ClassRegistry::init('Example.Post');
		$result = $Model->getAll();
		$expected = array(
			array(
				'Post' => array(
					'id' => 1,
					'author_id' => 1,
					'title' => 'First Post',
					'body' => 'First Post Body',
					'published' => 'Y',
					'created' => '2007-03-18 10:39:23',
					'updated' => '2007-03-18 10:41:31'
				)
			),
			array(
				'Post' => array(
					'id' => 2,
					'author_id' => 3,
					'title' => 'Second Post',
					'body' => 'Second Post Body',
					'published' => 'Y',
					'created' => '2007-03-18 10:41:23',
					'updated' => '2007-03-18 10:43:31'
				)
			),
			array(
				'Post' => array(
					'id' => 3,
					'author_id' => 1,
					'title' => 'Third Post',
					'body' => 'Third Post Body',
					'published' => 'Y',
					'created' => '2007-03-18 10:43:23',
					'updated' => '2007-03-18 10:45:31'
				)
			)
		);
		$this->assertEquals($expected, $result);
	}
}
