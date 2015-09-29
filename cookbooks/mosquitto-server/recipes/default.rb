include_recipe 'mosquitto::default'

cookbook_file '/etc/mosquitto/mosquitto-topics' do
  source 'mosquitto-topics'
  action :create
end

execute 'link-mosquitto-exec' do
  command 'ln -sf /usr/sbin/mosquitto /usr/bin/mosquitto'
end

execute 'mosquitto-brokker' do
  command "mosquitto -d -p 13000 -v &"
end

