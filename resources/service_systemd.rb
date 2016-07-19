provides :hubot_service_systemd

provides :hubot_service, platform: 'fedora'

provides :hubot_service, platform: %w(redhat centos scientific oracle) do |node| # ~FC005
  node['platform_version'].to_f >= 7.0
end

provides :hubot_service, platform: 'debian' do |node|
  node['platform_version'].to_i >= 8
end

provides :hubot_service, platform_family: 'suse' do |node|
  node['platform_version'].to_f >= 13.0
end

provides :hubot_service, platform: 'ubuntu' do |node|
  node['platform_version'].to_f >= 15.10
end

property :instance_name, String, name_property: true
property :install_path, String
property :hubot_user, kind_of: String, default: lazy { |r| "hubot_#{r.instance_name}" }
property :hubot_group, kind_of: String, default: lazy { |r| "hubot_#{r.instance_name}" }
property :env_vars, Array, default: [
  { 'CATALINA_PID' => '$CATALINA_BASE/bin/hubot.pid' }
]
property :sensitive, kind_of: [TrueClass, FalseClass], default: false

action :start do
  create_init

  service "hubot_#{new_resource.instance_name}" do
    provider Chef::Provider::Service::Systemd
    supports restart: true, status: true
    action :start
    only_if 'command -v java >/dev/null 2>&1 || exit 1'
  end
end

action :stop do
  service "hubot_#{new_resource.instance_name}" do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action :stop
    only_if { ::File.exist?("/etc/systemd/system/hubot_#{new_resource.instance_name}.service") }
  end
end

action :restart do
  service "hubot_#{new_resource.instance_name}" do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action :restart
  end
end

action :disable do
  service "hubot_#{new_resource.instance_name}" do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action :disable
    only_if { ::File.exist?("/etc/systemd/system/hubot_#{new_resource.instance_name}.service") }
  end
end

action :enable do
  create_init

  service "hubot_#{new_resource.instance_name}" do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action :enable
    only_if { ::File.exist?("/etc/systemd/system/hubot_#{new_resource.instance_name}.service") }
  end
end

action_class.class_eval do
  def create_init
    ensure_catalina_base

    template "/etc/systemd/system/hubot_#{instance_name}.service" do
      source 'init_systemd.erb'
      sensitive new_resource.sensitive
      variables(
        instance: new_resource.instance_name,
        env_vars: new_resource.env_vars,
        install_path: derived_install_path,
        user: new_resource.hubot_user,
        group: new_resource.hubot_group
      )
      cookbook 'hubot'
      owner 'root'
      group 'root'
      mode '0644'
      notifies :run, 'execute[Load systemd unit file]', :immediately
      notifies :restart, "service[hubot_#{new_resource.instance_name}]"
    end

    execute 'Load systemd unit file' do
      command 'systemctl daemon-reload'
      action :nothing
    end
  end
end
