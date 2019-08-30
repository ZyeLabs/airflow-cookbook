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
# default["airflow"]["user_uid"] = 9999
# default["airflow"]["group_gid"] = 9999
default["airflow"]["user_home_directory"] = "/home/#{node["airflow"]["user"]}"
default["airflow"]["shell"] = "/bin/bash"

# db config
default['airflow']['postgres']['user']      = "airflow"
default['airflow']['postgres']['passowrd']  = "airflow"

# General config
default["airflow"]["home"] = "/var/lib/airflow"
default["airflow"]["directories_mode"] = "0775"
default["airflow"]["config_file_mode"] = "0644"
default["airflow"]["bin_path"] = node["platform"] == "ubuntu" ? "/usr/local/bin" : "/usr/bin"
default["airflow"]["run_path"] = "/var/run/airflow"
default["airflow"]["is_upstart"] = node["platform"] == "ubuntu" && node["platform_version"].to_f < 15.04
default["airflow"]["init_system"] = node["airflow"]["is_upstart"] ? "upstart" : "systemd"
default["airflow"]["env_path"] = node["platform_family"] == "debian" ? "/etc/default/airflow" : "/etc/sysconfig/airflow"


# Python config
default["airflow"]["python_runtime"] = "3"
default["airflow"]["python_version"] = "3.6"
default["airflow"]["pip_version"] = '18.0'


#
# Core Settings --------------------------------------------------------------
#

default["airflow"]["config"]["core"]["dags_folder"] = "#{node["airflow"]["home"]}/dags"
default['airflow']["config"]["core"]["base_log_folder"]  = "#{node["airflow"]["home"]}/logs"
default['airflow']["config"]["core"]["dag_processor_manager_log_location"]  = "#{node["airflow"]["home"]}/logs/dag_processor_manager/dag_processor_manager.log"

default['airflow']['config']['core']['default_timezone'] = "system"
# possible values: SequentialExecutor, LocalExecutor, CeleryExecutor
default['airflow']["config"]["core"]["executor"]  = "LocalExecutor"
default["airflow"]["config"]["core"]["sql_alchemy_conn"] = "sqlite:///#{node["airflow"]["home"]}/airflow.db"
default["airflow"]["config"]["core"]["sql_alchemy_schema"] = "public"
default['airflow']["config"]["core"]["parallelism"] = 32
default['airflow']["config"]["core"]["dag_concurrency"] = 16
default['airflow']["config"]["core"]["dags_are_paused_at_creation"] = true
default['airflow']['config']['core']['load_examples'] = false
default["airflow"]["config"]["core"]["plugins_folder"] = "#{node["airflow"]["home"]}/plugins"
default["airflow"]["config"]["core"]["fernet_key"] = "55jB5--jCQpRYp73wUtpfw_S8zLRbrtGV8tr3dehnNer"
default['airflow']["config"]["core"]["dagbag_import_timeout"] = 60
default['airflow']["config"]["core"]["non_pooled_task_slot_count"] = 128
default['airflow']["config"]["core"]["max_active_runs_per_dag"] = 16
default['airflow']["config"]["core"]["security"] =''
default['airflow']["config"]["core"]["secure_mode"] = false


#
# web server configs ---------------------------------------------------
#

default['airflow']["config"]["webserver"]["base_url"] = "http://localhost:8888"
default['airflow']["config"]["webserver"]["web_server_host"] = '0.0.0.0'
default['airflow']["config"]["webserver"]["web_server_port"] = 8888
default['airflow']["config"]["webserver"]["workers"]  = 4
default['airflow']["config"]["webserver"]["expose_config"] = true
default['airflow']["config"]["webserver"]["authenticate"] = false
# default is false - (requires authentication to be enabled)
default['airflow']["config"]["webserver"]["filter_by_owner"] = false

default['airflow']["config"]["webserver"]["owner_mode"] = "user"
# authentication mechanism
# default['airflow']["config"]["webserver"]["auth_backend"] = "airflow.contrib.auth.backends.password_auth"

#
# Scheduler --------------------------------------------------------------
#

default['airflow']["config"]["scheduler"]["job_heartbeat_sec"]  = 5
# No of multiple threads in parallel to schedule dags.
default['airflow']["config"]["scheduler"]["max_threads"]  = 2
# Parse and schedule each file no faster than this interval.
default['airflow']["config"]["scheduler"]["min_file_process_interval"]  = 10
# How often in seconds to scan the DAGs directory for new files.
default['airflow']["config"]["scheduler"]["dag_dir_list_interval"] = 40
# How many seconds do we wait for tasks to heartbeat before mark them as zombies.
default['airflow']["config"]["scheduler"]["scheduler_zombie_task_threshold"] = 300
# How often should stats be printed to the logs
default['airflow']["config"]["scheduler"]["print_stats_interval"] = 600
