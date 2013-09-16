#!/bin/bash

if [ "$DB" = "mysql" ]; then mysql -e 'CREATE DATABASE cakephp_test;'; fi
if [ "$DB" = "pgsql" ]; then psql -c 'CREATE DATABASE cakephp_test;' -U postgres; fi

cd ..
git clone git://github.com/cakephp/cakephp.git --branch $CAKE_VERSION --depth 1
cd cakephp/app
chmod -R 777 tmp

cp ../../$REPO_NAME/composer.json ./composer.json;

composer install --dev --no-interaction --prefer-source

for dep in $REQUIRE;
do
    composer require --dev --no-interaction --prefer-source $dep;
done;

if [ "$COVERALLS" = '1' ]; then composer require --dev satooshi/php-coveralls:dev-master; fi

if [ "$PHPCS" = '1' ]; then pear channel-discover pear.cakephp.org; fi
if [ "$PHPCS" = '1' ]; then pear install --alldeps cakephp/CakePHP_CodeSniffer; fi

phpenv rehash

cp -R ../../$REPO_NAME Plugin/$PLUGIN_NAME

mv ./Plugin/$PLUGIN_NAME/.travis/ ./.travis/

mv ./.travis/database.php Config/database.php

set +H

echo "CakePlugin::loadAll();" >> Config/bootstrap.php

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<phpunit>
<filter>
    <whitelist>
        <directory suffix=\".php\">Plugin/$PLUGIN_NAME</directory>
        <exclude>
            <directory suffix=\".php\">Plugin/$PLUGIN_NAME/Test</directory>
        </exclude>
    </whitelist>
</filter>
</phpunit>" > phpunit.xml

echo "# for php-coveralls
src_dir: Plugin/$PLUGIN_NAME
coverage_clover: build/logs/clover.xml
json_path: build/logs/coveralls-upload.json" > .coveralls.yml
