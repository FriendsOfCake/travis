#!/bin/bash

# Move to APP
if [ -d ../cakephp/app ]; then
	cd ../cakephp/app
fi

if [ "$COVERAGE" = '1' ]; then
	sh -c "if [ '$CODECOVERAGE' = '1' ]; then wget -O codecov.sh https://codecov.io/bash; fi"
	sh -c "if [ '$CODECOVERAGE' = '1' ]; then bash codecov.sh; fi"
fi
