[![Build Status](https://travis-ci.org/GITHUB_USERNAME/REPO_NAME.png?branch=master)](https://travis-ci.org/GITHUB_USERNAME/REPO_NAME) [![Coverage Status](https://coveralls.io/repos/GITHUB_USERNAME/REPO_NAME/badge.png?branch=master)](https://coveralls.io/r/GITHUB_USERNAME/REPO_NAME?branch=master) [![Total Downloads](https://poser.pugx.org/GITHUB_USERNAME/REPO_NAME/d/total.png)](https://packagist.org/packages/GITHUB_USERNAME/REPO_NAME) [![Latest Stable Version](https://poser.pugx.org/GITHUB_USERNAME/REPO_NAME/v/stable.png)](https://packagist.org/packages/GITHUB_USERNAME/REPO_NAME)

# PLUGIN_NAME

## Background

## Requirements

* CakePHP 2.x
* PHP 5.3

## Installation

_[Using [Composer](http://getcomposer.org/)]_

Add the plugin to your project's `composer.json` - something like this:

```composer
  {
    "require": {
      "GITHUB_USERNAME/REPO_NAME": "dev-master"
    }
  }
```

Because this plugin has the type `cakephp-plugin` set in it's own `composer.json`, composer knows to install it inside your `/Plugins` directory, rather than in the usual vendors file. It is recommended that you add `/Plugins/PLUGIN_NAME` to your .gitignore file. (Why? [read this](http://getcomposer.org/doc/faqs/should-i-commit-the-dependencies-in-my-vendor-directory.md).)

_[Manual]_

* Download this: [http://github.com/GITHUB_USERNAME/REPO_NAME/zipball/master](http://github.com/GITHUB_USERNAME/REPO_NAME/zipball/master)
* Unzip that download.
* Copy the resulting folder to `app/Plugin`
* Rename the folder you just copied to `PLUGIN_NAME`

_[GIT Submodule]_

In your app directory type:

```bash
  git submodule add -b master git://github.com/GITHUB_USERNAME/REPO_NAME.git Plugin/PLUGIN_NAME
  git submodule init
  git submodule update
```

_[GIT Clone]_

In your `Plugin` directory type:

    git clone -b master git://github.com/GITHUB_USERNAME/REPO_NAME.git PLUGIN_NAME

### Enable plugin

In 2.0 you need to enable the plugin your `app/Config/bootstrap.php` file:

    CakePlugin::load('PLUGIN_NAME');

If you are already using `CakePlugin::loadAll();`, then this is not necessary.

## Usage

## TODO

## License

The MIT License (MIT)

Copyright (c) COPYRIGHT_YEAR YOUR_NAME

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
