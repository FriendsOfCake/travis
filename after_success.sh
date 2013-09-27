#!/bin/bash

# Move to APP
cd ../cakephp/app

if [ "$COVERALLS" = '1' ]; then
    php vendor/bin/coveralls -c .coveralls.yml -v;
fi
