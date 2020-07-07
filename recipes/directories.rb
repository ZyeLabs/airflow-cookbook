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


directory node["airflow"]["install_path"]  do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  recursive true
  action :create
end

directory node["airflow"]["home_root"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory node["airflow"]["home"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory "airflow-chef" do
  path ::File.join(node["airflow"]["install_path"], "chef")
  owner node["airflow"]["user"]
  group "root"
  action :create
end

directory node["airflow"]["config"]["core"]["dags_folder"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory node["airflow"]["config"]["core"]["base_log_folder"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory node["airflow"]["config"]["core"]["plugins_folder"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory node["airflow"]["run_path"] do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

directory "~/.pip" do
  path ::File.join(node["airflow"]["user_home_directory"], ".pip")
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

link "dags" do
  target_file ::File.join(node["airflow"]["home"], "dags")
  to node["airflow"]["config"]["core"]["dags_folder"]
end

link "logs" do
  target_file ::File.join(node["airflow"]["home"], "logs")
  to node["airflow"]["config"]["core"]["base_log_folder"]
end



