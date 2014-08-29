<?php

App::uses('AppModel', 'Model');

class Post extends AppModel {

/**
 * Retrieves all records
 *
 * @return array
 */
	public function getAll() {
		return $this->find('all', array(
			'order' => array('Post.id' => 'ASC')
		));
	}
}
