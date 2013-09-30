#!/bin/bash

if [ ! -z "${PLUGIN_PATH}" ]; then
  cd $PLUGIN_PATH
fi

success=true
if [ ! -f "CONTRIBUTING.markdown" -a ! -f "CONTRIBUTING.md" ]; then
  echo "Missing CONTRIBUTING.markdown"
  success=false
fi

if [ ! -f "LICENSE.txt" ]; then
  echo "Missing LICENSE.txt"
  success=false
fi

if [ ! -f "README.markdown" -a ! -f "README.md" ]; then
  echo "Missing README.markdown"
  success=false
fi

if [ ! -f ".editorconfig" ]; then
  echo "Missing .editorconfig"
  success=false
fi

if [ ! -f ".semver" ]; then
  echo "Missing .semver"
  success=false
fi

if [ ! -f ".travis.yml" ]; then
  echo "Missing .travis.yml"
  success=false
else
  if ! grep -q PLUGIN_NAME ".travis.yml"; then
    echo "Missing PLUGIN_NAME global environment variable in yml file"
    success=false
  elif grep -q PLUGIN_NAME=ExamplePlugin ".travis.yml"; then
    echo "PLUGIN_NAME should be set to your plugin's name, not ExamplePlugin"
    success=false
  fi
fi


composer -q validate || {
  echo 'Invalid composer.json file'
  success=false
}

if [ -z "${PLUGIN_NAME}" ]; then
  echo "Please set PLUGIN_NAME environment variable to your plugin's CakePHP name"
  success=false
elif [ ! -f "Test/Case/All${PLUGIN_NAME}Test.php" ]; then
  echo "Missing Test/Case/All${PLUGIN_NAME}Test.php"
  success=false
fi

if $success; then
  echo "Valid FOC plugin"
  exit 0
else
  exit 1
fi
