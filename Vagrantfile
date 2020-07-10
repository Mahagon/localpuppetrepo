# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |configs|
  username = ENV["urname"] || 'test'
  device = "srfcpro4"
  configs.vm.define "#{device}" do |config|
    config.vm.box = "archlinux/archlinux"
    config.vm.hostname = "#{username}#{device}"
    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 4
      v.customize ["modifyvm", :id, "--vram", "32"]
    end
    config.vm.provision "shell", inline: <<-SHELL
    yes | pacman -Sy
    yes | LC_ALL=en_US.UTF-8 pacman -S puppet
    SHELL
  end
end