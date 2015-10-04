mosquitto_url = "http://repo.mosquitto.org/debian/"
mosquitto_repo = "mosquitto-repo"

AUTOGRASS_CONF_DIR = '/home/autograss/.config/'
server = data_bag_item('mosquitto','server')

apt_package 'curl'

execute 'mosquitto:repo' do
  command "curl -O #{mosquitto_url}#{mosquitto_repo}.gpg.key"
  command "apt-key add #{mosquitto_repo}.gpg.key"
  command "rm #{mosquitto_repo}.gpg.key"
  command "cd /etc/apt/sources.list.d/"
  command "curl -O #{mosquitto_url}#{mosquitto_repo}.list"
end

execute 'apt-update' do
  command 'apt-get update'
end

apt_package 'mosquitto mosquitto-clients python-mosquitto'

directory "#{server['home']}" do
  owner 'autograss'
  group 'sudo'
  mode '0755'
  action :create
end

user 'autograss' do
  shell '/bin/bash'
  home "#{server['home']}"
  system true
  action :create
end

group 'sudo' do
  action :modify
  members 'autograss'
  append true
end

directory "#{AUTOGRASS_CONF_DIR}" do
  owner 'autograss'
  group 'sudo'
  mode '0755'
  action :create
end
