ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

VAGRANTFILE_API_VERSION = "2"

CURRENT_DIR = Dir.pwd

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "server" do |web|
    web.vm.provider "docker" do |d|
      d.name = "s2dock"
      d.build_dir = "."
      d.ports = [ "1234:1234" ]
      d.privileged = true
      d.volumes = [ CURRENT_DIR + ":/src/s2dock" ]
    end
  end

end
