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

# User configuration
default["airflow"]["airflow_package"] = 'apache-airflow' # use 'airflow' for version <= 1.8.0
default["airflow"]["version"] = "1.10.4"
default["airflow"]["user"] = "airflow"
default["airflow"]["group"] = "airflow"
default["airflow"]["groups"] = ['hadoop', 'airflow']
# default["airflow"]["user_uid"] = 9999
# default["airflow"]["group_gid"] = 9999
default["airflow"]["user_home_directory"] = "/home/#{node["airflow"]["user"]}"
default["airflow"]["shell"] = "/bin/bash"
default['airflow']['authorized_keys'] = []

# db config
default['airflow']['postgres']['user']      = "airflow"
default['airflow']['postgres']['passowrd']  = "airflow"

# General config
default["airflow"]["install_path_root"] = "/opt/airflow"
default["airflow"]["install_path_current"]  = "/opt/airflow/current"
default["airflow"]["install_path"] = "#{node["airflow"]["install_path_root"]}/airflow-#{node["airflow"]["version"]}"
default["airflow"]["venv_path"] = "#{node["airflow"]["install_path"]}/venv"
default["airflow"]["home_root"] = "/var/lib/airflow"
default["airflow"]["home_current"] = "/var/lib/airflow/current"
default["airflow"]["home"] = "#{node["airflow"]["home_root"]}/airflow-#{node["airflow"]["version"]}"

default["airflow"]["directories_mode"] = "0775"
default["airflow"]["config_file_mode"] = "0644"
# default["airflow"]["bin_path"] = node["platform"] == "ubuntu" ? "/usr/local/bin" : "/usr/bin"
default["airflow"]["bin_path"] = "#{node["airflow"]["venv_path"]}/bin"

default["airflow"]["run_path"] = "/var/run/airflow"
default["airflow"]["is_upstart"] = node["platform"] == "ubuntu" && node["platform_version"].to_f < 15.04
default["airflow"]["init_system"] = node["airflow"]["is_upstart"] ? "upstart" : "systemd"
default["airflow"]["env_path"] = node["platform_family"] == "debian" ? "/etc/default/airflow" : "/etc/sysconfig/airflow"
 default['airflow']["scheduler_runs"] = 5
# Number of seconds to execute before exiting
default['airflow']["scheduler_duration"] = 21600


# Python config
default["airflow"]["python_runtime"] = "3"
default["airflow"]["python_version"] = "3.6"
default["airflow"]["pip_version"] = '18.1'

# metadata DB config
default['airflow']['database']['engine'] = 'postgresql+psycopg2'
default['airflow']['database']['server'] = 'database-server.cluster.net'
default['airflow']['database']['port'] = '5432'
default['airflow']['database']['name'] = 'airflow'
default['airflow']['database']['user'] = 'airflow'
default['airflow']['database']['schema'] = 'airflow'
default['airflow']['database']['password'] = 'airflow'


default['airflow']["operators"] = %w(async crypto hdfs hive jdbc kerberos ldap postgres oracle webhdfs)


#
# Core Settings --------------------------------------------------------------
#

default["airflow"]["config"]["core"]["dags_folder"] = "#{node["airflow"]["home_root"]}/dags"
default['airflow']["config"]["core"]["base_log_folder"]  = "#{node["airflow"]["home"]}/logs"
default['airflow']["config"]["core"]["dag_processor_manager_log_location"]  = "#{node["airflow"]["home"]}/logs/dag_processor_manager/dag_processor_manager.log"

default['airflow']['config']['core']['default_timezone'] = "Africa/Johannesburg"
# possible values: SequentialExecutor, LocalExecutor, CeleryExecutor
default['airflow']["config"]["core"]["executor"] = "LocalExecutor"
default["airflow"]["config"]["core"]["sql_alchemy_conn"] = "postgresql+psycopg2://airflow:airflow@localhost:5432/airflow"

default["airflow"]["config"]["core"]["sql_alchemy_conn"] = "sqlite:///#{node["airflow"]["home"]}/airflow.db"
default["airflow"]["config"]["core"]["sql_alchemy_schema"] = "public"
default['airflow']["config"]["core"]["parallelism"] = 16
# max number of tasks that can be running per DAG (across multiple DAG runs) concurrently
default['airflow']["config"]["core"]["dag_concurrency"] = 16
default['airflow']["config"]["core"]["dags_are_paused_at_creation"] = true
default['airflow']['config']['core']['load_examples'] = false
default["airflow"]["config"]["core"]["plugins_folder"] = "#{node["airflow"]["home"]}/plugins"
default["airflow"]["config"]["core"]["fernet_key"] = "QcPpFrJdc1glC79ZXwJKvf0jXz9psu83EMP2GXCBf9I="
default['airflow']["config"]["core"]["dagbag_import_timeout"] = 60
default['airflow']["config"]["core"]["non_pooled_task_slot_count"] = 128
# Default value for concurrent dagruns (running instances of the dag) is 16.
# To avoid unexpected behavour setting it to 1. it can be set at dag level using max_active_runs param
default['airflow']["config"]["core"]["max_active_runs_per_dag"] = 1
default['airflow']["config"]["core"]["security"] ='kerberos' # for non-kerberos mode set it to empty string ''
default['airflow']["config"]["core"]["secure_mode"] = false


#
# web server configs ---------------------------------------------------
#

default['airflow']["config"]["webserver"]["base_url"] = "http://localhost:8888"
default['airflow']["config"]["webserver"]["host"] = '0.0.0.0'
default['airflow']["config"]["webserver"]["port"] = 8888
default['airflow']["config"]["webserver"]["workers"]  = 4
default['airflow']["config"]["webserver"]["expose_config"] = true
default['airflow']["config"]["webserver"]["authenticate"] = true
# default is false - (requires authentication to be enabled)
default['airflow']["config"]["webserver"]["filter_by_owner"] = false
default['airflow']["config"]["webserver"]["owner_mode"] = "user"
# authentication mechanism
default['airflow']["config"]["webserver"]["auth_backend"] = "airflow.contrib.auth.backends.ldap_auth"

#
# Scheduler --------------------------------------------------------------
#

default['airflow']["config"]["scheduler"]["max_threads"] = 12
default['airflow']["config"]["scheduler"]["authenticate"] = false
default['airflow']["config"]["scheduler"]["min_file_process_interval"] = 60
default['airflow']["config"]["scheduler"]["dag_dir_list_interval"] = 300

#
# Kerberos --------------------------------------------------------------
#

default['airflow']["config"]["kerberos"]["principal"] = "airflow"
default['airflow']["config"]["kerberos"]["keytab"] = "#{node["airflow"]["home"]}/airflow.keytab"
default['airflow']["config"]["kerberos"]["ccache"] = "/tmp/airflow_krb5_ccache"

#
# ldap --------------------------------------------------------------
#

default['airflow']["config"]["ldap"]["uri"] = "ldap://za.cellc.net:389"
default['airflow']["config"]["ldap"]["user_filter"] = "objectclass=user"
default['airflow']["config"]["ldap"]["user_name_attr"] = "sAMAccountName"
default['airflow']["config"]["ldap"]["group_member_attr"] = "memberOf"
default['airflow']["config"]["ldap"]["superuser_filter"] = "memberOf=CN=hadoop_dev,OU=Security Groups,OU=Groups,DC=ZA,DC=CellC,DC=net"
default['airflow']["config"]["ldap"]["data_profiler_filter"] = "memberOf=CN=hadoop_dev,OU=Security Groups,OU=Groups,DC=ZA,DC=CellC,DC=net"
default['airflow']["config"]["ldap"]["bind_user"] = "CN=hadoop,OU=SMC Dashboard,DC=ZA,DC=CellC,DC=net"
default['airflow']["config"]["ldap"]["bind_password"] = "pass"
default['airflow']["config"]["ldap"]["basedn"] = "dc=za,dc=cellc,dc=net"
# default value for search scope is LEVEL. for AD if not explicitly specifying an OU that your users are in, use SUBTREE
default['airflow']["config"]["ldap"]["search_scope"] = "SUBTREE"
# if not using sldap (secure) leave cacert emoty, otherwise point to the certificate file path
default['airflow']["config"]["ldap"]["cacert"] = ""

