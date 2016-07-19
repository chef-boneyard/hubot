require 'spec_helper'

describe 'default recipe on Ubuntu 14.04' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['hubot_instance'], platform: 'ubuntu', version: '16.04').converge('test::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
