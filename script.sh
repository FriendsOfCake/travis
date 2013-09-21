#!/bin/bash

if [ "$PHPCS" != '1' ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml;
else
    phpcs -p --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME;
fi

