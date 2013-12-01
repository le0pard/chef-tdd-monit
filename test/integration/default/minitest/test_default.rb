require 'minitest/spec'

describe 'monit::default' do

  it "install monit" do
    package("monit").must_be_installed
  end

  describe "services" do

    # You can assert that a service must be running following the converge:
    it "runs as a daemon" do
      service("monit").must_be_running
    end

    # And that it will start when the server boots:
    it "boots on startup" do
      service("monit").must_be_enabled
    end

  end

end