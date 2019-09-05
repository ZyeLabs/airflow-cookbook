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
venv_path = node["airflow"]["install_path"]
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

# NB. the popise-python library doesn't work with pip version higher than 18.0
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

# require 'chef/mixin/shell_out'
# # passenger_root = shell_out("pip3 show pip").status == 1
# exit_code = shell_out("pip3 show pip >/dev/null 2>&1; echo $?").stdout.to_i

# log "*********output result1: #{exit_code}"

# exit_code = shell_out("pip3 show pipaa >/dev/null 2>&1; echo $?").stdout.to_i

# log "*********output result2: #{exit_code}"


# pip_package "tornado" do
#   package_name "tornado"
#   version ">=5.2.0"
#   user airflow_user
#   group  airflow_group
#   virtualenv venv_path
# end

# install packages within env
# execute "install-packages" do
#   user node["airflow"]["user"]
#   cwd venv_path
#   command " pip install apache-airflow[#{airflow_packages_list}]"
#   notifies :run, "execute[activate-env]", :before
#   notifies :run, "execute[deactivate-env]", :immediately
# end

# bash "install-greenlet" do
#   user airflow_user
#   group  airflow_group
#   cwd venv_path
#   code <<-EOH
#     source bin/activate
#     export SLUGIFY_USES_TEXT_UNIDECODE=yes
#     pip install 'greenlet>=0.4.9'
#     deactivate
#   EOH
  # command " pip install apache-airflow[#{airflow_packages_list}]"
  # notifies :run, "execute[activate-env]", :before
  # notifies :run, "execute[ßdeactivate-env]", :immediately
#end

# airflow_packages.each do |package|
#   execute "install-#{package}-package" do
#     command "pip install apache-airflow[#{package}]"
#     only_if "pip show pip"

#   end

# end

# execute "activate-env" do
#   user node["airflow"]["user"]
#   command "source #{::File.join(venv_path, "bin/activate")}"
#   action :nothing
# end

# execute "deactivate-env" do
#   user node["airflow"]["user"]
#   command "deactivate"
#   action :nothing
# end
