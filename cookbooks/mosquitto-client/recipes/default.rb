include_recipe 'mosquitto::default'

execute 'mosquitto-brokker' do
  command "mosquitto_pub -h 192.168.50.4 -p 13000 -m teste -t 'Ola Mundo' & "
end

