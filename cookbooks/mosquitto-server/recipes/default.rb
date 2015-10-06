include_recipe 'mosquitto::default'

MOSQUITO_CONF_DIR = '/etc/mosquitto/conf.d'
AUTOGRASS_CONF_DIR = '/home/autograss/.config'

apt_package 'sqlite'

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

execute 'change-pid-owner' do
  command 'chown autograss:sudo /var/run/mosquitto.pid'
end

# No debian, quando um pacote é instalado, seu serviço é automativamente
# iniciado
service 'mosquitto' do
  action :restart
end
