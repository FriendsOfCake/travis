#!/bin/bash

if [ "$DB" = "mysql" ]; then mysql -e 'CREATE DATABASE cakephp_test;'; fi
if [ "$DB" = "pgsql" ]; then psql -c 'CREATE DATABASE cakephp_test;' -U postgres; fi

cd ..
git clone git://github.com/cakephp/cakephp.git --branch $CAKE_VERSION --depth 1
cd cakephp/app

if [ "$COVERALLS" = '1' ]; then composer require --dev satooshi/php-coveralls:dev-master; fi
if [ "$COVERALLS" = '1' ]; then composer install --dev --no-interaction --prefer-source; fi

if [ "$PHPCS" = '1' ]; then pear channel-discover pear.cakephp.org; fi
if [ "$PHPCS" = '1' ]; then pear install --alldeps cakephp/CakePHP_CodeSniffer; fi

phpenv rehash

cp -R ../../$REPO_NAME Plugin/$PLUGIN_NAME
chmod -R 777 tmp

set +H
echo "<?php
    class DATABASE_CONFIG {
    private \$identities = array(
      'mysql' => array(
        'datasource' => 'Database/Mysql',
        'host' => '0.0.0.0',
        'login' => 'travis'
      ),
      'pgsql' => array(
        'datasource' => 'Database/Postgres',
        'host' => '127.0.0.1',
        'login' => 'postgres',
        'database' => 'cakephp_test',
        'schema' => array(
          'default' => 'public',
          'test' => 'public'
        )
      )
    );
    public \$default = array(
      'persistent' => false,
      'host' => '',
      'login' => '',
      'password' => '',
      'database' => 'cakephp_test',
      'prefix' => ''
    );
    public \$test = array(
      'persistent' => false,
      'host' => '',
      'login' => '',
      'password' => '',
      'database' => 'cakephp_test',
      'prefix' => ''
    );
    public function __construct() {
      \$db = 'mysql';
      if (!empty(\$_SERVER['DB'])) {
        \$db = \$_SERVER['DB'];
      }
      foreach (array('default', 'test') as \$source) {
        \$config = array_merge(\$this->{\$source}, \$this->identities[\$db]);
        if (is_array(\$config['database'])) {
          \$config['database'] = \$config['database'][\$source];
        }
        if (!empty(\$config['schema']) && is_array(\$config['schema'])) {
          \$config['schema'] = \$config['schema'][\$source];
        }
        \$this->{\$source} = \$config;
      }
    }
}" > Config/database.php

echo "CakePlugin::loadAll();" >> Config/bootstrap.php

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<phpunit>
<filter>
    <whitelist>
        <directory suffix=\".php\">plugins/$PLUGIN_NAME</directory>
        <exclude>
            <directory suffix=\".php\">plugins/$PLUGIN_NAME/Test</directory>
        </exclude>
    </whitelist>
</filter>
</phpunit>" > phpunit.xml

echo "# for php-coveralls
src_dir: Plugin/$PLUGIN_NAME
coverage_clover: build/logs/clover.xml
json_path: build/logs/coveralls-upload.json" > .coveralls.yml