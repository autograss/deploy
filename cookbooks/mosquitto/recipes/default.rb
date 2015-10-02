mosquitto_url = "http://repo.mosquitto.org/debian/"
mosquitto_repo = "mosquitto-repo"

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
