# hubot cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/hubot.svg)](https://travis-ci.org/chef-cookbooks/hubot) [![Cookbook Version](https://img.shields.io/cookbook/v/hubot.svg)](https://supermarket.chef.io/cookbooks/hubot)

Deploys and manages an instance of [GitHub's Hubot](https://hubot.github.com/).

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle

### Chef

- Chef 12.1+

### Cookbooks

- [nodejs](https://supermarket.chef.io/cookbooks/nodejs)
- [git](https://supermarket.chef.io/cookbooks/git)
- [runit](https://supermarket.chef.io/cookbooks/runit)

## Recipes

### default

- Ensures that Node.js is installed and available using the
- [nodejs cookbook](http://community.opscode.com/cookbooks/nodejs).
- Ensures git is installed and available using the
- [git cookbook](http://community.opscode.com/cookbooks/git).
- Ensures runit is installed and available using the
- [runit cookbook](http://community.opscode.com/cookbooks/runit).
- Creates a user and group to install and run the Hubot instance under.
- Installs the specified Hubot version from git.
- Renders instance-specific `package.json`, `external-scripts.json`, `hubot-scripts.json`, and
- `hubot.conf` files.
- Creates and enables a `hubot` runit service to run the Hubot instance under.
- The runit service reads the `hubot.conf` file and passes the contents onto
- the underlying hubot process as configuration.

## Attributes

Attribute        | Description                                                                                                                                                        | Type   | Default
---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------ | ----------
version          | Hubot version to install.                                                                                                                                          | String | 2.11.0     |
scripts_version  | Version of [hubot-scripts](https://github.com/github/hubot-scripts) (community collection of hubot scripts) to install.                                            | String | 2.5.16
install_dir      | Directory the Hubot instance will be installed to.                                                                                                                 | String | /opt/hubot
user             | The user to install and run the Hubot instance under.                                                                                                              | String | hubot
group            | The group to install and run the Hubot instance under.                                                                                                             | String | hubot
name             | The name of the robot in chat.                                                                                                                                     | String | hubot
adapter          | The [Hubot adapter](https://github.com/github/hubot/blob/master/docs/adapters.md) to use.                                                                          | String | campfire
config           | Hash of values that will be converted into environment variables and passed to the Hubot process.                                                                  | Hash   | Hash.new
dependencies     | Hash in form `dep_name => dep_version` that will be rendered into Hubot instance's `package.json`. A common dep to set in this attribute is non-Campfire adapters. | Hash   | Hash.new
hubot_scripts    | Scripts to enable from the [community collection of hubot scripts](https://github.com/github/hubot-scripts).                                                       | Array  | Array.new
external_scripts | External scripts to enable.                                                                                                                                        | Array  | Array.new

## Usage

Include `recipe[hubot]` in your run_list and override the defaults you want changed. See [below](#attributes) for more details. Hubot instances are configured using environment variables passed to the Hubot process. These environment variables can be set using the `node['hubot']['config']` attribute.

I highly recommend integrating this cookbook into your own infrastructure using the [library/application cookbook pattern](http://devopsanywhere.blogspot.com/2012/11/how-to-write-reusable-chef-cookbooks.html). You would start by creating a `YOURCOMPANY-hubot` cookbook with a proper metadata dependency on the `hubot` (this) cookbook. A concrete example can be found [on this gist](https://gist.github.com/schisamo/46eafba27d43c4a1e026) which was created from bits of the internal `opscode-hubot` cookbook which we use to deploy, Paula Deen, Chef's hubot instance.

One important item to note is the use of the [remote_directory](http://docs.opscode.com/resource_remote_directory.html) resource to distribute our internal hubot scripts to the install:

```ruby
remote_directory "#{node['hubot']['install_dir']}/scripts" do
  source "scripts"
  files_backup 0
  files_owner node['hubot']['user']
  files_group node['hubot']['group']
  files_mode '0644'
  owner node['hubot']['user']
  group node['hubot']['group']
  overwrite true
  mode '0755'
  notifies :restart, "service[hubot]", :delayed
end
```

## License & Authors

**Author:** [Seth Chisamore][schisamo] ([schisamo@gmail.com](mailto:schisamo@gmail.com))

**Author:** [Tim Smith][tas50] ([tsmith@chef.io](mailto:tsmith@chef.io))

**Copyright:** 2013-2015, Seth Chisamore

**Copyright:** 2015, Tim Smith **Copyright:** 2016, Chef Software, Inc

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
