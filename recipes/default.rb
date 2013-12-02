#
# Cookbook Name:: hubot
# Recipe:: default
#
# Copyright (c) 2013, Seth Chisamore
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git"
include_recipe "runit"

case node['platform_family']
when "debian"
  node.set['nodejs']['install_method'] = "package"
else
  node.set['nodejs']['install_method'] = "source"
end

include_recipe "nodejs"

user node['hubot']['user'] do
  comment "Hubot User"
  home node['hubot']['install_dir']
end

group node['hubot']['group'] do
  members [node['hubot']['user']]
end

directory node['hubot']['install_dir'] do
  owner node['hubot']['user']
  group node['hubot']['group']
  recursive true
  mode  0755
end

# https://github.com/github/hubot/archive/v2.4.6.zip
checkout_location = ::File.join(Chef::Config[:file_cache_path], "hubot")
git checkout_location do
  repository "https://github.com/github/hubot.git"
  revision "v#{node['hubot']['version']}"
  action :checkout
  notifies :run, "execute[build and install hubot]", :immediately
end

execute "build and install hubot" do
  command <<-EOH
npm install
bin/hubot -c #{node['hubot']['install_dir']}
chown #{node['hubot']['user']}:#{node['hubot']['group']} -R #{node['hubot']['install_dir']}
chmod 0755 #{node['hubot']['install_dir']}/bin/hubot
  EOH
  cwd checkout_location
  environment(
    "PATH" => "#{checkout_location}/node_modules/.bin:#{ENV['PATH']}"
  )
  action :nothing
end

template "#{node['hubot']['install_dir']}/package.json" do
  source 'package.json.erb'
  owner node['hubot']['user']
  group node['hubot']['group']
  mode 0644
  variables node['hubot'].to_hash
  notifies :run, "execute[npm install]", :immediately
end

template "#{node['hubot']['install_dir']}/hubot-scripts.json" do
  source 'hubot-scripts.json.erb'
  owner node['hubot']['user']
  group node['hubot']['group']
  mode 0644
  variables node['hubot'].to_hash
  notifies :restart, "service[hubot]", :delayed
end

execute "npm install" do
  cwd node['hubot']['install_dir']
  user node['hubot']['user']
  group node['hubot']['group']
  environment(
    "USER" => node['hubot']['user'],
    "HOME" => node['hubot']['install_dir']
  )
  action :nothing
  notifies :restart, "service[hubot]", :delayed
end

runit_service "hubot" do
  options node['hubot'].to_hash
  env node['hubot']['config']
end
