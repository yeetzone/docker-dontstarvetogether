# Version
Vagrant.require_version '>= 1.8.0'

# Configuration
Vagrant.configure('2') do |config|

  # Base
  config.vm.box = 'boxcutter/ubuntu1510'
  config.vm.box_version = '>= 2.0'
  config.vm.hostname = 'dsta-server'

  # Ports
  config.vm.network :forwarded_port, guest: 10999, host: 10999, protocol: 'udp'
  config.vm.network :forwarded_port, guest: 11000, host: 11000, protocol: 'udp'
  config.vm.network :forwarded_port, guest: 11001, host: 11001, protocol: 'udp'

  # SSH
  config.ssh.forward_agent = true

  # VirtualBox
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = 'DST:A Server'
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
      provider.vmx['displayName'] = 'DST:A Server'
      provider.vmx['guestOS'] = 'ubuntu-64'
      provider.vmx['numvcpus'] = 2
      provider.vmx['memsize'] = 4096
    end
  end

  # Parallels
  config.vm.provider :parallels do |provider, config|
    provider.gui = false
    provider.name = 'DST:A Server'
    provider.cpus = 2
    provider.memory = 4096
    provider.optimize_power_consumption = false
  end

  # Provision
  config.vm.provision :shell, path: 'install.sh'
end
