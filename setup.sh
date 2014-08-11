#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_TEST_DIR="Test/Case"
PLUGIN_ALL_TEST="${PLUGIN_TEST_DIR}/All${PLUGIN_NAME}Test.php"

if [ -z "${PLUGIN_NAME}" ]; then
	PLUGIN_NAME = ${PWD##*/}
fi

echo ""
echo -e "Using the following configuration:\n"
echo -e "\tPLUGIN_NAME:     $PLUGIN_NAME"
echo ""

if [ ! -f ".travis.yml" ]; then
	echo "Templating .travis.yml"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_2=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/ExamplePlugin/$PLUGIN_NAME/g" $DIR/templates/.travis.yml > $TMP_FILE
	sed -e "s/example_plugin/$REPO_NAME/g" $TMP_FILE > $TMP_FILE_2
	mv $TMP_FILE_2 .travis.yml
fi

if [ ! -d "$PLUGIN_TEST_DIR" ]; then
	echo "Missing $PLUGIN_TEST_DIR directory, creating"
	mkdir -p $PLUGIN_TEST_DIR
fi

if [ ! -f "Test/Case/All${PLUGIN_NAME}Test.php" ]; then
	echo "Templating Test/Case/All${PLUGIN_NAME}Test.php"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" $DIR/templates/AllPluginNameTest.php > $TMP_FILE
	mv $TMP_FILE $PLUGIN_ALL_TEST
fi

CYAN="\033[0;36m"
NO_COLOUR="\033[0m"
echo -e "${CYAN}Remember to setup your plugin on https://coveralls.io/ for coverage tracking${NO_COLOUR}"
echo -e ""
echo -e "${CYAN}Make sure you have the http://travis-ci.org webhook enabled in github for your plugin${NO_COLOUR}"
echo -e ""
echo -e "Templating complete"
