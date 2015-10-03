include_recipe 'mosquitto::default'

MOSQUITO_CONF_DIR = '/etc/mosquitto/conf.d'
AUTOGRASS_CONF_DIR = '/home/autograss/.mosquitto/'

apt_package 'sqlite'


directory '/home/autograss/' do
  owner 'autograss'
  group 'sudo'
  mode '0755'
  action :create
end

user 'autograss' do
  shell '/bin/bash'
  home '/home/autograss/'
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

template "#{MOSQUITO_CONF_DIR}/autograss.conf" do
  source 'autograss.conf.erb'
  mode '0750'
  owner 'autograss'
  group 'sudo'
  variables({:autograss_conf_dir => AUTOGRASS_CONF_DIR})
end

cookbook_file "#{AUTOGRASS_CONF_DIR}/autograss_topics" do
  source 'autograss_topics'
  owner 'autograss'
  action :create
end

execute 'link-mosquitto-exec' do
  command 'ln -sf /usr/sbin/mosquitto /usr/bin/mosquitto'
end

execute 'mosquitto-brokker' do
  command "mosquitto -c #{MOSQUITO_CONF_DIR}/autograss.conf -d -v"
end
