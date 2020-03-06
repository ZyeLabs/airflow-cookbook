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

# group node["airflow"]["group"] do
#   action :create
# end

node["airflow"]["groups"].each do |group|
  group group do
    append true
  end
end

user_account node["airflow"]["user"] do
  comment "Airflow user"
  gid node["airflow"]["group"]
  ssh_keygen false
  groups node["airflow"]["groups"]
  home node["airflow"]["user_home_directory"]
  shell node["airflow"]["shell"]
  action :create
end

# user node["airflow"]["user"] do
#   comment "Airflow user"
#   gid node['airflow']['group']
#   home node["airflow"]["user_home_directory"]
#   manage_home true
#   shell node["airflow"]["shell"]
# end






