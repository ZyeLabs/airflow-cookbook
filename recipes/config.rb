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
ldap_bind_pass = ChefVault::Item.load(:credentials, 'ldap-bind')['password']

node.default["airflow"]["config"]["core"]["sql_alchemy_conn"] = "#{db_engine}://#{db_user}:#{db_pass}@#{db_server}:#{db_port}/#{db_name}"
node.default["airflow"]["config"]["ldap"]["bind_password"] = ldap_bind_pass

template "#{node["airflow"]["home"]}/airflow.cfg" do
  source "airflow.cfg.erb"
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

service "airflow-webserver" do
  action :nothing
end

service "airflow-scheduler" do
  action :nothing
end
