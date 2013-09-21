#!/bin/bash

PLUGIN_TEST_DIR="Plugin/${PLUGIN_NAME}/Test/Case"
PLUGIN_ALL_TEST="${PLUGIN_TEST_DIR}/All${PLUGIN_NAME}Test.php"

if [ "$DB" = "mysql" ]; then mysql -e 'CREATE DATABASE cakephp_test;'; fi
if [ "$DB" = "pgsql" ]; then psql -c 'CREATE DATABASE cakephp_test;' -U postgres; fi

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

if [ ! -d "$PLUGIN_TEST_DIR" ]; then
    mkdir -p $PLUGIN_TEST_DIR
    echo "Missing $PLUGIN_TEST_DIR directory, creating"
fi

if [ ! -f "$PLUGIN_ALL_TEST" ]; then
    echo "Missing $PLUGIN_ALL_TEST, templating file for now"
    echo "Contents will include the following:"
    echo ""
    mv ./travis/AllPluginNameTest.php $PLUGIN_ALL_TEST
    sed -i "s/PLUGIN_NAME/$PLUGIN_NAME/g" $PLUGIN_ALL_TEST
    cat $PLUGIN_ALL_TEST | sed 's/^/\t/'
    echo ""
fi

mv ./travis/database.php Config/database.php

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
