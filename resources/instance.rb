property :instance_name, String, name_property: true
property :version, String, default: '2.19.0'
property :install_path, String, default: lazy { |r| "/opt/hubot_#{r.instance_name}" }
property :hubot_user, String, default: lazy { |r| "hubot_#{r.instance_name}" }
property :hubot_group, String, default: lazy { |r| "hubot_#{r.instance_name}" }

action_class do
end

action :install do
  group new_resource.hubot_group do
    action :create
    append true
  end

  user new_resource.hubot_user do
    gid new_resource.hubot_group
    shell '/bin/nologin'
    system true
    action :create
  end

  directory 'hubot install dir' do
    mode '0750'
    path new_resource.install_path
    recursive true
    owner new_resource.hubot_user
    group new_resource.hubot_group
  end

  git new_resource.install_path do
    repository 'https://github.com/github/hubot.git'
    revision "v#{new_resource.version}"
    user new_resource.hubot_user
    group new_resource.hubot_group
    notifies :install, 'nodejs_npm[install]', :immediately
  end

  nodejs_npm 'install' do
    path new_resource.install_path
    json true
    action :nothing
  end
end
