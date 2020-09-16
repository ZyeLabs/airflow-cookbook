# Copyright 2015 Sergey Bahchissaraitsev

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# helper = PostgresCluster::Helper.new(node)

default_db_pass = node['airflow']['database']['password']
db_pass = ChefVault::Item.load(:credentials, 'pg-airflow')['password'] rescue default_db_pass
db_user = node['airflow']['database']['user']
db_engine = node['airflow']['database']['engine']
db_server = node['airflow']['database']['server']
db_port = node['airflow']['database']['port']
db_name = node['airflow']['database']['name']
ldap_bind_pass = ChefVault::Item.load(:credentials, node['airflow']["config"]["ldap"]["vault_pass_key"])['password']

node.default["airflow"]["config"]["core"]["sql_alchemy_conn"] = "#{db_engine}://#{db_user}:#{db_pass}@#{db_server}:#{db_port}/#{db_name}"
node.default["airflow"]["config"]["ldap"]["bind_password"] = ldap_bind_pass

template "#{node["airflow"]["home"]}/airflow.cfg" do
  source "airflow-#{node["airflow"]["version"]}.cfg.erb"
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["config_file_mode"]
  variables(
    lazy do
      {
        :config => node['airflow']['config']
      }
    end
  )
  notifies :restart, 'service[airflow-scheduler]', :delayed
  notifies :restart, 'service[airflow-webserver]', :delayed
end

execute "init-db" do
  cwd node["airflow"]["venv_path"]
  user node["airflow"]["user"]
  command "AIRFLOW_HOME=#{node["airflow"]["home"]} bin/airflow initdb"
  live_stream true
  creates ::File.join(node["airflow"]["install_path"], "chef", ".db-configured")
  notifies :create, "file[db-configured]", :immediately
end

execute "upgrade-db" do
  cwd node["airflow"]["venv_path"]
  user node["airflow"]["user"]
  command "AIRFLOW_HOME=#{node["airflow"]["home"]} bin/airflow upgradedb"
  live_stream true
  creates ::File.join(node["airflow"]["install_path"], "chef", ".db-upgraded")
  notifies :create, "file[db-upgraded]", :immediately
end

file "db-configured" do
  path ::File.join(node["airflow"]["install_path"], "chef", ".db-configured")
  content ''
  mode '644'
  owner 'root'
  group 'root'
  action :nothing
end

file "db-upgraded" do
  path ::File.join(node["airflow"]["install_path"], "chef", ".db-upgraded")
  content ''
  mode '644'
  owner 'root'
  group 'root'
  action :nothing
end

link "current-home" do
  target_file node["airflow"]["home_current"]
  to node["airflow"]["home"]
  owner node['airflow']['user']
  group node['airflow']['group']
  only_if { ::File.exists?(::File.join(node["airflow"]["install_path"], "chef", ".build-done")) and
            ::File.exists?(::File.join(node["airflow"]["install_path"], "chef", ".db-configured")) and
            ::File.exists?(::File.join(node["airflow"]["install_path"], "chef", ".db-upgraded")) }
end

template "airflow_runner.sh" do
  path ::File.join(node["airflow"]["home"], "airflow_runner.sh")
  source "airflow_runner.sh.erb"
  owner node['airflow']['user']
  group node['airflow']['group']
  mode "0740"
  variables({
    :app_dir => node["airflow"]["venv_path"],
    :bin_dir => node["airflow"]["bin_path"]
  })
end

template "ulimits" do
  path "/etc/security/limits.d/airflow.conf"
  source 'ulimits.conf.erb'
  mode "644"
  variables(
    nofile: node["airflow"]["ulimit"]["nofile"],
    nproc: node["airflow"]["ulimit"]["nproc"]
  )
end

template "webserver_config.py" do
  path ::File.join(node["airflow"]["home"], "webserver_config.py")
  source "webserver_config.py.erb"
  owner node['airflow']['user']
  group node['airflow']['group']
  mode '600'
  variables(
    config: node['airflow']['config']
  )
  notifies :restart, 'service[airflow-webserver]', :delayed
end

service "airflow-webserver" do
  action :nothing
  only_if "systemctl list-units --full -all | grep -Fq 'airflow-webserver.service'"
end

service "airflow-scheduler" do
  action :nothing
  only_if "systemctl list-units --full -all | grep -Fq 'airflow-scheduler.service'"
end
