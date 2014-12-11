#!/bin/bash

if [ "$PHPCS" == 1 ]; then
    ARGS="-p --extensions=php --standard=vendor/cakephp/cakephp-codesniffer/CakePHP --ignore=vendor/ .";
    if [ -n "$PHPCS_IGNORE" ]; then
        ARGS="$ARGS --ignore='$PHPCS_IGNORE'"
    fi
    if [ -n "$PHPCS_ARGS" ]; then
        ARGS="$PHPCS_ARGS"
    fi
    eval "vendor/bin/phpcs" $ARGS
    exit $?
fi

# Move to APP
if [ -d ../cakephp/app ]; then
	cd ../cakephp/app
fi

EXIT_CODE=0

if [ "$COVERALLS" == 1 ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml
    EXIT_CODE="$?"
elif [ -z "$FOC_VALIDATE" ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr
    EXIT_CODE="$?"
fi

if [ "$EXIT_CODE" -gt 0 ]; then
    exit 1
fi
exit 0
