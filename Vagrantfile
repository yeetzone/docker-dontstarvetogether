$script = <<SCRIPT
export DEBIAN_FRONTEND=noninteractive

# Update Packages
apt-get update

# Install Dependencies
apt-get install -y curl dnsmasq linux-image-extra-$(uname -r)
sleep 1

# Install Docker Engine
curl -sSL https://get.docker.com/ | sh

# Install Docker Compose
curl -sSL https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add the vagrant-user to the Docker group
usermod -aG docker vagrant
SCRIPT

# Version
Vagrant.require_version '>= 1.8.0'

# Configuration
Vagrant.configure('2') do |config|

  # Base
  config.vm.box = 'bento/ubuntu-15.04'
  config.vm.box_version = '>= 2.2'
  config.vm.hostname = 'dst-server'

  # Ports
  config.vm.network :forwarded_port, guest: 10999, host: 10999, protocol: 'udp'
  config.vm.network :forwarded_port, guest: 11000, host: 11000, protocol: 'udp'
  config.vm.network :forwarded_port, guest: 11001, host: 11001, protocol: 'udp'

  # SSH
  config.ssh.forward_agent = true

  # VirtualBox
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = 'Don\'t Starve Together'
    provider.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
    provider.customize ['modifyvm', :id, '--memory', 4096]
    provider.customize ['modifyvm', :id, '--acpi', 'on']
    provider.customize ['modifyvm', :id, '--cpus', 2]
    provider.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
    provider.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    provider.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    provider.customize ['modifyvm', :id, '--ioapic', 'on']
  end

  # VMware
  [:vmware_workstation, :vmware_fusion].each do |provider|
    config.vm.provider provider do |provider, config|
      provider.gui = false
      provider.vmx['displayName'] = 'Don\'t Starve Together'
      provider.vmx['guestOS'] = 'ubuntu-64'
      provider.vmx['numvcpus'] = 2
      provider.vmx['memsize'] = 4096
    end
  end

  # Parallels
  config.vm.provider :parallels do |provider, config|
    provider.gui = false
    provider.name = 'Don\'t Starve Together'
    provider.cpus = 2
    provider.memory = 4096
    provider.optimize_power_consumption = false
  end

  # Provision
  config.vm.provision :shell, inline: $script
end
