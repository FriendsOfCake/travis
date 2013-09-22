#!/bin/bash

# Move to APP
cd ../cakephp/app

if [ "$PHPCS" != '1' ]; then
    ./Console/cake test $PLUGIN_NAME All$PLUGIN_NAME --stderr --coverage-clover build/logs/clover.xml;
else
    phpcs -p --ignore='*/Test/*' --extensions=php --standard=CakePHP ./Plugin/$PLUGIN_NAME;
fi
