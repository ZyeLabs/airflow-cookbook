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

ENV['SLUGIFY_USES_TEXT_UNIDECODE'] = 'yes'
venv_path = node['airflow']["venv_path"]
requried_packages = node['airflow']["operators"]
airflow_packages = node['airflow']['packages']
airflow_user = node["airflow"]["user"]
airflow_group = node["airflow"]["group"]



# Obtain the current platform name
platform = node['platform'].to_sym

# Default dependencies to install
dependencies_to_install = []
node['airflow']['dependencies'][platform][:default].each do |dependency|
  dependencies_to_install << dependency
end

# Use the airflow package strings to add dependent packages to install.
requried_packages.each do |package|
  if node['airflow']['dependencies'][platform].key?(package.to_sym)
    node['airflow']['dependencies'][platform][package.to_sym].each do |dependency|
      dependencies_to_install << dependency
    end
  end
end

if(requried_packages.include?('all'))
  raise ArgumentError, "Sorry, currently all and devel airflow pip packages are not supported in this cookbook. For more info, please see the README.md file."
end


# Install dependencies
dependencies_to_install.each do |value|
  package_to_install = ''
  version_to_install = ''
  value.each do |key, val|
    if key.to_s == 'name'
      package_to_install = val
    else
      version_to_install = val
    end
  end
  package package_to_install do
    action  :install
    version version_to_install
  end
end

# NB. the poise-python library doesn't work with pip version higher than 18.0
# for centos at the moment. issue https://github.com/poise/poise-python/issues/140
python_virtualenv venv_path do
  user airflow_user
  group  airflow_group
  path venv_path
  python "/usr/bin/python3"
  pip_version "18.0"
  setuptools_version true
  wheel_version false
end

# Install the apache-airflow core package
pip_package 'apache-airflow' do
  package_name node["airflow"]["airflow_package"]
  version node["airflow"]["version"]
  user airflow_user
  group  airflow_group
  virtualenv venv_path
end

packages_to_install = []
requried_packages.each do |package|
  if airflow_packages[package.to_sym]
    packages_to_install +=  airflow_packages[package.to_sym]
  else
    raise ArgumentError, "The specified operator was not found in the airflow's operators list! Operator => #{package}"
  end
end

packages_to_install.each do |package|
  pip_package "airflow-package-#{package[:name]}" do
    package_name package[:name]
    version package[:version]
    user airflow_user
    group  airflow_group
    virtualenv venv_path
  end
end

file "build-done" do
  path ::File.join(node["airflow"]["install_path"], "chef", ".build-done")
  content ''
  mode '644'
  owner 'root'
  group 'root'
  action :create
end

link "current-app" do
  target_file node["airflow"]["install_path_current"]
  to node["airflow"]["install_path"]
  user airflow_user
  group  airflow_group
  only_if { ::File.exists?(::File.join(node["airflow"]["install_path"], "chef", ".build-done")) }
end
