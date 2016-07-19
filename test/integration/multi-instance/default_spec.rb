describe file('/opt/hubot_helloworld_8_0_36/LICENSE') do
  it { should be_file }
  it { should be_owned_by 'cool_user' }
  its('group') { should eq 'cool_group' }
end

describe file('/opt/special/hubot_docs_7_0_42/LICENSE') do
  it { should be_file }
  it { should be_owned_by 'hubot_helloworld' }
  its('group') { should eq 'hubot_helloworld' }
end

describe command('curl http://localhost:8081/sample/') do
  its('stdout') { should match(/Hello, World/) }
end

describe command('curl http://localhost:8080/') do
  its('stdout') { should match(/successfully installed hubot/) }
end

%w(hubot_helloworld hubot_docs).each do |service_name|
  describe user(service_name) do
    it { should exist }
  end

  describe group(service_name) do
    it { should exist }
  end

  describe service(service_name) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
