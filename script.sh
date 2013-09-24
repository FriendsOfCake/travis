#!/bin/bash

if [ -z "$PHPCS" -a -z "$FOC_VALIDATE" ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml;
fi

if [ "$PHPCS" == 1 ]; then
    phpcs -p --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME;
fi

if [ "$FOC_VALIDATE" == 1 ]; then
    export PLUGIN_PATH="Plugin/$PLUGIN_NAME"
    echo "./travis/validate.sh"
    ./travis/validate.sh
fi
