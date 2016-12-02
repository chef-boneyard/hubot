apt_update 'update' if platform_family?('debian')

include_recipe 'git::default'

# make sure node is actually installed
include_recipe 'nodejs::default'

hubot_instance 'bug_bot'
