# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 16")
  end

  def os_version
    command("lsb_release -a").stdout
  end

  # This test is new
  it "installs required packages" do
    expect(package("tmux")).to be_installed
    expect(package("vim")).to be_installed
    expect(package("nodejs")).to be_installed
  end

end
