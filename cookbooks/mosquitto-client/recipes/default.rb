include_recipe 'mosquitto::default'

server = data_bag_item('mosquitto','server')

AUTOGRASS_CONF_DIR = "#{server['home']}/.config"

clients = data_bag_item('mosquitto','pub')
host = clients['host']
port = clients['port']

directory "#{server['home']}/.config" do
  owner 'autograss'
  group 'sudo'
  mode '0755'
  action :create
end

template "#{AUTOGRASS_CONF_DIR}/mosquitto_sub" do
  source 'mosquitto_sub.erb'
  mode '0750'
  owner 'autograss'
  group 'sudo'
  variables({:host => host, :port => port})
end
