# hubot cookbook

Deploys and manages an instance of [GitHub's Hubot](http://hubot.github.com/).

# Usage

Include `recipe[hubot]` in your run_list and override the defaults you want
changed. See [below](#-attributes) for more details. Hubot instances are
configured using environment variables passed to the Hubot process. These
environment variables can be set using the `node['hubot']['config']` attribute.

# Requirements

## Chef

Tested on Chef 11 but newer and older version should work just fine. File an
[issue][issues] if this isn't the case.

## Platform

The following platforms have been tested with this cookbook, meaning that the
recipes and LWRPs run on these platforms without error:

* Ubuntu 10.04, 11.04, 12.04, 12.10
* CentOS 6

## Cookbooks

This cookbook depends on the following external cookbooks:

* [nodejs](http://community.opscode.com/cookbooks/nodejs) (mdxp)
* [git](http://community.opscode.com/cookbooks/git) (Opscode)
* [runit](http://community.opscode.com/cookbooks/runit) (Opscode)

# Recipes

## default

* Ensures that Node.js is installed and available using the
  [nodejs cookbook](http://community.opscode.com/cookbooks/nodejs).
* Ensures git is installed and available using the
  [git cookbook](http://community.opscode.com/cookbooks/git).
* Ensures runit is installed and available using the
  [runit cookbook](http://community.opscode.com/cookbooks/runit).
* Creates a user and group to install and run the Hubot instance under.
* Installs the specified Hubot version from git.
* Renders instance-specific `package.json`, `hubot-scripts.json`, and
 `hubot.conf` files.
* Creates and enables a `hubot` runit service to run the Hubot instance under.
  The runit service reads the `hubot.conf` file and passes the contents onto
  the underlying hubot process as configuraiton.

# Attributes

Attribute       | Description |Type | Default
----------------|-------------|-----|--------
version         | Hubot version to install. | String  | 2.4.6      |
scripts_version | Version of [hubot-scripts](https://github.com/github/hubot-scripts) (community collection of hubot scripts) to install. | String | 2.4.1
install_dir     | Directory the Hubot instance will be installed to. | String | /opt/hubot
user            | The user to install and run the Hubot instance under. | String | hubot
group           | The group to install and run the Hubot instance under. | String | hubot
name            | The name of the robot in chat. | String | hubot
adapter         | The [Hubot adapter](https://github.com/github/hubot/wiki) to use. | String | campfire
config          | Hash of values that will be converted into environment variables and passed to the Hubot process. | Hash | Hash.new
dependencies    | Hash in form `dep_name => dep_version` that will be rendered into Hubot instance's `package.json`. A common dep to set in this attribute is non-Campfire adapters. | Hash | Hash.new
hubot_scripts   | Scripts to enable from the [community collection of hubot scripts](https://github.com/github/hubot-scripts). | Array | Array.new

# Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

I <3 pull requests! Make sure your patches are well tested. Ideally create a
topic branch for every separate feature/fix you make.

# License and Author

Author:: [Seth Chisamore][schisamo] (<schisamo@gmail.com>) [![endorse](http://api.coderwall.com/schisamo/endorsecount.png)](http://coderwall.com/schisamo)

Copyright (c) 2013, Seth Chisamore

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[schisamo]:      https://github.com/schisamo
[repo]:          https://github.com/schisamo-cookbooks/hubot
[issues]:        https://github.com/schisamo-cookbooks/hubot/issues
