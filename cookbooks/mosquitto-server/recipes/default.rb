include_recipe 'mosquitto::default'

cookbook_file "#{$PERSONAL_MOSQUITTO_CONF}/mosquitto_topics" do
  source 'mosquitto_topics'
  action :create
end

cookbook_file "#{$PERSONAL_MOSQUITTO_CONF}/mosquitto.conf" do
  source 'mosquitto.conf'
  action :create
end

execute 'link-mosquitto-exec' do
  command 'ln -sf /usr/sbin/mosquitto /usr/bin/mosquitto'
end

execute 'mosquitto-brokker' do
  command "mosquitto -d -p 13000 -v"
end

