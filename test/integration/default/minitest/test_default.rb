require 'minitest/autorun'

describe 'monit::default' do

  it "install monit" do
    assert system('apt-cache policy monit | grep Installed | grep -v none')
  end

  describe "services" do

    # You can assert that a service must be running following the converge:
    it "runs as a daemon" do
      assert system('/etc/init.d/monit status')
    end

    # And that it will start when the server boots:
    it "boots on startup" do
      assert File.exists?(Dir.glob("/etc/rc5.d/S*monit").first)
    end

  end

end