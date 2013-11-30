require 'chefspec'

describe 'monit::default' do
  let(:platfom) { 'ubuntu' }
  let(:platfom_version) { '12.04' }
  let(:chef_run) { ChefSpec::Runner.new(platform: platfom, version: platfom_version).converge(described_recipe) }

  it 'install monit package' do
    expect(chef_run).to install_package('monit')
  end

  it 'enable monit service' do
    expect(chef_run).to enable_service('monit')
  end

  context "ubuntu system" do
    it 'create direcory for custom services' do
      expect(chef_run).to create_directory('/etc/monit/conf.d').with(
        user:   'root',
        group:  'root'
      )
    end

    it 'create main monit config' do
      expect(chef_run).to create_template('/etc/monit/monitrc')
    end

    it 'reload daemon on change config' do
      resource = chef_run.template('/etc/monit/monitrc')
      expect(resource).to notify('service[monit]').to(:restart)
    end
  end

  context "rhel system" do
    let(:platfom) { 'centos' }
    let(:platfom_version) { '6.3' }

    it 'create direcory for custom services' do
      expect(chef_run).to create_directory('/etc/monit.d').with(
        user:   'root',
        group:  'root'
      )
    end

    it 'create main monit config' do
      expect(chef_run).to create_template('/etc/monit.conf')
    end

    it 'reload daemon on change config' do
      resource = chef_run.template('/etc/monit.conf')
      expect(resource).to notify('service[monit]').to(:restart)
    end
  end

end