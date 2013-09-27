#!/bin/bash

# Move to APP
cd ../cakephp/app

if [ "$COVERALLS" == 1 ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml
elif [ -z "$PHPCS" -a -z "$FOC_VALIDATE" ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr
fi

if [ "$PHPCS" == 1 ]; then
    phpcs -p --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME
fi

if [ "$FOC_VALIDATE" == 1 ]; then
    export PLUGIN_PATH="Plugin/$PLUGIN_NAME"
    ../../travis/validate.sh

    EXIT_CODE="$?"
    if [ "$FOC_TRAVIS" == 1 ]; then
        # When running FriendsOfCake/travis plugin itself we want it to fail
        # We need the inverse: Failures are good, Passes are bad
        EXIT_CODE=$([ "$EXIT_CODE" == 0 ] && echo 1 || echo 0)
    fi

    exit $EXIT_CODE
fi
