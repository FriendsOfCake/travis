#!/bin/bash

# Move to APP
if [ -d ../cakephp/app ]; then
	cd ../cakephp/app
fi

if [ "$COVERALLS" = '1' ]; then
    php vendor/bin/coveralls -c .coveralls.yml -v;
fi
