#!/bin/bash

composer self-update

if [ "$PHPCS" = '1' ]; then
	composer require 'cakephp/cakephp-codesniffer:1.*';
	exit 0
fi

#
# Returns the latest reference (either a branch or tag) for any given
# MAJOR.MINOR semantic versioning.
#
latest_ref() {
	# Get version from master branch
	MASTER=$(curl --silent https://raw.githubusercontent.com/cakephp/cakephp/2.x/lib/Cake/VERSION.txt)
	MASTER=$(echo "$MASTER" | tail -1 | grep -Ei "^$CAKE_VERSION\.")
	if [ -n "$MASTER" ]; then
		echo "master"
		exit 0
	fi

	# Check if any branch matches CAKE_VERSION
	BRANCH=$(curl --silent https://api.github.com/repos/cakephp/cakephp/git/refs/heads)
	BRANCH=$(echo "$BRANCH" | grep -Ei "\"refs/heads/$CAKE_VERSION\"" | grep -oEi "$CAKE_VERSION" | tail -1)
	if [ -n "$BRANCH" ]; then
		echo "$BRANCH"
		exit 0
	fi

	# Get the latest tag matching CAKE_VERSION.*
	TAG=$(curl --silent https://api.github.com/repos/cakephp/cakephp/git/refs/tags)
	TAG=$(echo "$TAG" | grep -Ei "\"refs/tags/$CAKE_VERSION\." | grep -oEi "$CAKE_VERSION\.[^\"]+" | tail -1)
	if [ -n "$TAG" ]; then
		echo "$TAG"
		exit 0
	fi
}

if [ "$DB" = "mysql" ]; then mysql -e 'CREATE DATABASE cakephp_test;'; fi
if [ "$DB" = "pgsql" ]; then psql -c 'CREATE DATABASE cakephp_test;' -U postgres; fi

REPO_PATH=$(pwd)
SELF_PATH=$(cd "$(dirname "$0")"; pwd)

# Clone CakePHP repository
if [ -z "$CAKE_REF" ]; then
	CAKE_REF=$(latest_ref)
fi
if [ -z "$CAKE_REF" ]; then
	echo "Found no valid ref to match with version $CAKE_VERSION" >&2
	exit 1
fi

git clone git://github.com/cakephp/cakephp.git --branch $CAKE_REF --depth 1 ../cakephp

# Prepare plugin
cd ../cakephp/app

chmod -R 777 tmp

cp -R $REPO_PATH Plugin/$PLUGIN_NAME

mv $SELF_PATH/database.php Config/database.php

COMPOSER_JSON="$(pwd)/Plugin/$PLUGIN_NAME/composer.json"
if [ -f "$COMPOSER_JSON" ]; then
    cp $COMPOSER_JSON ./composer.json;
    composer install --no-interaction --prefer-source
fi

for dep in $REQUIRE; do
    composer require --no-interaction --prefer-source $dep;
done

if [ "$PHPCS" != '1' ]; then
	composer global require 'phpunit/phpunit=3.7.38'
	ln -s ~/.composer/vendor/phpunit/phpunit/PHPUnit ./Vendor/PHPUnit
fi

phpenv rehash

set +H

echo "CakePlugin::loadAll(array(array('bootstrap' => true, 'routes' => true, 'ignoreMissing' => true)));" >> Config/bootstrap.php

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<phpunit>
<filter>
    <whitelist>
        <directory suffix=\".php\">Plugin/$PLUGIN_NAME</directory>
        <exclude>
            <directory suffix=\".php\">Plugin/$PLUGIN_NAME/Test</directory>
            <directory suffix=\".php\">Plugin/$PLUGIN_NAME/vendor</directory>
        </exclude>
    </whitelist>
</filter>
</phpunit>" > phpunit.xml
