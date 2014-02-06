#!/bin/bash

# Move to APP
if [ -d ../cakephp/app ]; then
	cd ../cakephp/app
fi

if [ -z "$COMPOSER_VENDOR" ]; then
    COMPOSER_VENDOR="vendor"
fi

if [ "$COVERALLS" = '1' ]; then
    php $COMPOSER_VENDOR/bin/coveralls -c .coveralls.yml -v;
fi
