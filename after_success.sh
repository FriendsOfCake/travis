#!/bin/bash

# Move to APP
cd ../cakephp/app

if [ -z "$COMPOSER_VENDOR" ]; then
    COMPOSER_VENDOR="vendor"
fi

if [ "$COVERALLS" = '1' ]; then
    php $COMPOSER_VENDOR/bin/coveralls -c .coveralls.yml -v;
fi
