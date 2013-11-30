require 'chefspec'

describe 'monit::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'install monit package' do
    expect(chef_run).to install_package('monit')
  end

  it 'enable monit service' do
    expect(chef_run).to enable_service('monit')
  end

  it 'create direcory for custom services' do
    expect(chef_run).to create_directory('/etc/monit/conf.d/').with(
      user:   'root',
      group:  'root'
    )
  end

  it 'create main monit config' do
    expect(chef_run).to create_template('/etc/monit/monitrc')
  end

end