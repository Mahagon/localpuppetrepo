# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 2.0.0'
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |configs|
  username = ENV["urname"] || 'test'
  codedir = "/vagrant"
  puppetcodedir = "#{codedir}/puppetcode"
  device = "srfcpro4"
  configs.vm.define "#{device}" do |config|
    config.vm.box = "archlinux/archlinux"
    config.vm.hostname = "#{username}#{device}"
    # config.vm.synced_folder ".", "/vagrant", type: "rsync"
    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 4
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      v.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
      v.customize ["modifyvm", :id, "--monitorcount", "2"]
    end
    config.vm.provision "shell", name: 'pacman', inline: <<-SHELL
    pacman -Syu --noconfirm
    pacman --noconfirm --needed --noprogressbar -S git puppet fakeroot lttng-ust openssl-1.0 sudo virtualbox-guest-utils
    SHELL
    config.vm.provision "shell", name: 'install powershell and puppet modules', privileged: false, inline: <<-SHELL
    if ! pwsh --version &> /dev/null
    then
      cd ~
      git clone https://aur.archlinux.org/powershell-bin.git
      cd powershell-bin/
      makepkg -sic --noconfirm --noprogressbar
    fi
    pwsh -File #{codedir}/puppet_install_modules.ps1 #{puppetcodedir}
    SHELL
    config.vm.provision "shell", name: 'puppet apply', inline: <<-SHELL
    cd #{puppetcodedir}
    puppet apply --modulepath modules manifests/site.pp --hiera_config hiera.yaml --debug
    SHELL
  end
end