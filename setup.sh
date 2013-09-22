#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_TEST_DIR="Test/Case"
PLUGIN_ALL_TEST="${PLUGIN_TEST_DIR}/All${PLUGIN_NAME}Test.php"

if [ ! -z "${PLUGIN_PATH}" ]; then
	cd $PLUGIN_PATH
fi

if [ -z "${COPYRIGHT_YEAR}" ]; then
	echo "Please set COPYRIGHT_YEAR environment variable to your plugin's copyright year"
	exit 1
fi

if [ -z "${GITHUB_USERNAME}" ]; then
	_GITHUB_USERNAME=`git config --get github.user`
	if [ -n "${_GITHUB_USERNAME}" ]; then
		echo "Setting GITHUB_USERNAME to '$_GITHUB_USERNAME' from 'git config --get github.user'"
		GITHUB_USERNAME=$_GITHUB_USERNAME
	else
		echo "Please set GITHUB_USERNAME environment variable to your github username"
		exit 1
	fi
fi

if [ -z "${PLUGIN_NAME}" ]; then
	echo "Please set PLUGIN_NAME environment variable to your plugin's CakePHP name"
	exit 1
fi

if [ -z "${REPO_NAME}" ]; then
	if [ -d .git ]; then
		remotes=$(git remote -v | awk -F'git@github.com:' '{print $2}' | cut -d" " -f1)
		if [ -z "$remotes" ]; then
			remotes=$(git remote -v | awk -F'https://github.com/' '{print $2}' | cut -d" " -f1)
		fi

		_REPO_NAME=$(echo $remotes | cut -d" " -f1 | cut -d"/" -f2 | cut -d"." -f1)
	fi

	if [ -n "${_REPO_NAME}" ]; then
		echo "Setting REPO_NAME to '$_REPO_NAME' from 'git remote -v'"
		REPO_NAME=$_REPO_NAME
	else
		echo "Please set REPO_NAME environment variable to your plugin's repository name"
		exit 1
	fi
fi

if [ -z "${YOUR_NAME}" ]; then
		_YOUR_NAME=`git config --get user.name`
	if [ -n "${_YOUR_NAME}" ]; then
		echo "Setting GITHUB_USERNAME to '$_GITHUB_USERNAME' from 'git config --get user.name'"
		YOUR_NAME=$_YOUR_NAME
	else
		echo "Please set YOUR_NAME environment variable to your copyright name"
		exit 1
	fi
fi

echo ""
echo -e "Using the following configuration:\n"
echo -e "\tCOPYRIGHT_YEAR:  $COPYRIGHT_YEAR"
echo -e "\tGITHUB_USERNAME: $GITHUB_USERNAME"
echo -e "\tPLUGIN_NAME:     $PLUGIN_NAME"
echo -e "\tREPO_NAME:       $REPO_NAME"
echo -e "\tYOUR_NAME:       $YOUR_NAME"
echo ""

if [ ! -f "CONTRIBUTING.markdown" -a ! -f "CONTRIBUTING.md" ]; then
	echo "Templating CONTRIBUTING.markdown"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_2=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_3=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" $DIR/templates/CONTRIBUTING.markdown > $TMP_FILE
	sed -e "s/REPO_NAME/$REPO_NAME/g" $TMP_FILE > $TMP_FILE_2
	sed -e "s/GITHUB_USERNAME/$GITHUB_USERNAME/g" $TMP_FILE_2 > $TMP_FILE_3
	mv $TMP_FILE_3 CONTRIBUTING.markdown
fi

if [ ! -f "LICENSE.txt" ]; then
	echo "Templating LICENSE.txt"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_2=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/COPYRIGHT_YEAR/$COPYRIGHT_YEAR/g" $DIR/templates/LICENSE.txt > $TMP_FILE
	sed -e "s/YOUR_NAME/$YOUR_NAME/g" $TMP_FILE > $TMP_FILE_2
	mv $TMP_FILE_2 LICENSE.txt
fi

if [ ! -f "README.markdown" -a ! -f "README.md" ]; then
	echo "Templating README.markdown"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_2=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_3=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_4=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_5=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" $DIR/templates/README.markdown > $TMP_FILE
	sed -e "s/REPO_NAME/$REPO_NAME/g" $TMP_FILE > $TMP_FILE_2
	sed -e "s/GITHUB_USERNAME/$GITHUB_USERNAME/g" $TMP_FILE_2 > $TMP_FILE_3
	sed -e "s/COPYRIGHT_YEAR/$COPYRIGHT_YEAR/g" $TMP_FILE_3 > $TMP_FILE_4
	sed -e "s/YOUR_NAME/$YOUR_NAME/g" $TMP_FILE_4 > $TMP_FILE_5
	mv $TMP_FILE_5 README.markdown
fi

if [ ! -f ".editorconfig" ]; then
	echo "Templating .editorconfig"
	cp $DIR/templates/.editorconfig .editorconfig
fi

if [ ! -f ".semver" ]; then
	echo "Templating .semver"
	cp $DIR/templates/.semver .semver
fi

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

if [ ! -f "composer.json" ]; then
	echo "Templating composer.json"
	TMP_FILE=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_2=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_3=`mktemp /tmp/config.XXXXXXXXXX`
	TMP_FILE_4=`mktemp /tmp/config.XXXXXXXXXX`
	sed -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" $DIR/templates/composer.json > $TMP_FILE
	sed -e "s/REPO_NAME/$REPO_NAME/g" $TMP_FILE > $TMP_FILE_2
	sed -e "s/GITHUB_USERNAME/$GITHUB_USERNAME/g" $TMP_FILE_2 > $TMP_FILE_3
	sed -e "s/YOUR_NAME/$YOUR_NAME/g" $TMP_FILE_3 > $TMP_FILE_4
	mv $TMP_FILE_4 composer.json
fi

CYAN="\033[0;36m"
NO_COLOUR="\033[0m"
echo -e "${CYAN}Remember to setup your plugin on https://coveralls.io/ for coverage tracking${NO_COLOUR}"
echo -e ""
echo -e "${CYAN}Make sure you have the http://travis-ci.com webhook enabled in github for your plugin${NO_COLOUR}"
echo -e ""
echo -e "Templating complete"
