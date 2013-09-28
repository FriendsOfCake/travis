#!/bin/bash

# Move to APP
cd ../cakephp/app

TEST_EXIT_CODE=0
PHPCS_EXIT_CODE=0
VALIDATE_EXIT_CODE=0

if [ "$COVERALLS" == 1 ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml
    TEST_EXIT_CODE="$?"
elif [ -z "$PHPCS" -a -z "$FOC_VALIDATE" ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr
    TEST_EXIT_CODE="$?"
fi

if [ "$PHPCS" == 1 ]; then
    phpcs -p --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME
    PHPCS_EXIT_CODE="$?"
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

    VALIDATE_EXIT_CODE="$EXIT_CODE"
fi

EXIT_CODE=$(($TEST_EXIT_CODE + $PHPCS_EXIT_CODE + $VALIDATE_EXIT_CODE))
if [ "$EXIT_CODE" -gt 0 ]; then
    exit 1
fi
exit 0
