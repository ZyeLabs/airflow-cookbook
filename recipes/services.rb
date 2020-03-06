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

template "airflow_env" do
  source "init_system/airflow-env.erb"
  path node["airflow"]["env_path"]
  owner "root"
  group "root"
  mode "0644"
  variables({
    :airflow_home => node["airflow"]["home_current"],
    :scheduler_duration => node["airflow"]["scheduler_duration"],
    :scheduler_runs => node["airflow"]["scheduler_runs"],
  })
end
