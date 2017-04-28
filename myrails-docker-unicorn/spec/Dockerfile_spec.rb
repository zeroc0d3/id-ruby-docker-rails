# spec/Dockerfile_spec.rb

require "serverspec"
require "docker-api"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  # This test is new
  #it "installs required packages" do
  #  expect(package("nodejs")).to be_installed
  #end

  def os_version
    command("lsb_release -a").stdout
  end
end
