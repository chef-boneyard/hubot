name             'hubot'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      "Deploys and manages an instance of Github's Hubot."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.7'

supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 6.0'
supports 'redhat', '>= 6.0'

depends 'git'
depends 'nodejs'
depends 'runit'
depends 'supervisor'

source_url 'https://github.com/chef-cookbooks/hubot'
issues_url 'https://github.com/chef-cookbooks/hubot/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
