name             'hubot'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache 2.0'
description      "Deploys and manages an instance of Github's Hubot."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

depends 'compat_resource', '>= 12.10'

%w(ubuntu debian redhat centos suse opensuse opensuseleap scientific oracle amazon zlinux).each do |os|
  supports os
end

depends 'nodejs'

source_url 'https://github.com/chef-cookbooks/hubot'
issues_url 'https://github.com/chef-cookbooks/hubot/issues'
chef_version '>= 12.1'
