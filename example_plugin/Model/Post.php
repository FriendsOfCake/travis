<?php

App::uses('AppModel', 'Model');

class Post extends AppModel {

	public function getAll() {
		return $this->find('all', array(
			'order' => array('Post.id' => 'ASC')
		));
	}
}
