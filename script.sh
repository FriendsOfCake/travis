#!/bin/bash

if [ "$PHPCS" != '1' -a "$COMPOSER_VALIDATE" != '1' ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml;
fi

if [ "$PHPCS" == 1 ]; then
    phpcs -p --ignore='*/Test/*' --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME;
fi

if [ "$COMPOSER_VALIDATE" == 1 ]; then
    composer -d ./Plugin/$PLUGIN_NAME validate
fi

