# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "server" do |server|
    server.vm.box = "thoughtbot/debian-jessie-64"
    server.vm.network "public_network"

    server.vm.provision "shell", inline: <<-shell
     sudo apt-get update
     sudo apt-get install -y sudo vim
    shell
  end

  config.vm.define "client" do |client|
    client.vm.box = "thoughtbot/debian-jessie-64"
    client.vm.network "private_network", ip: "192.168.50.5"

    client.vm.provision "shell", inline: <<-shell
     sudo apt-get update
     sudo apt-get install -y sudo vim
    shell
  end
end
