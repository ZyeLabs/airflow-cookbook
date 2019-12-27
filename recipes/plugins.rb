#
# Cookbook:: airflow
# Recipe:: plugins
#
# Copyright:: 2019, The Authors, All Rights Reserved.

plugin_dir = node["airflow"]["config"]["core"]["plugins_folder"]

directory plugin_dir do
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  mode node["airflow"]["directories_mode"]
  action :create
end

remote_directory "plugin-hooks" do
  path ::File.join(plugin_dir,"hooks")
  source "hooks"
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  files_owner node["airflow"]["user"]
  files_group node["airflow"]["group"]
  action :create
end

remote_directory "plugin-operators" do
  path ::File.join(plugin_dir,"operators")
  source "operators"
  owner node["airflow"]["user"]
  group node["airflow"]["group"]
  files_owner node["airflow"]["user"]
  files_group node["airflow"]["group"]
  action :create
end

# only enable when there are files under the folder, otherwise chef-client throws an error
# remote_directory "plugin-sensors" do
#   path ::File.join(plugin_dir,"sensors")
#   source "sensors"
#   owner node["airflow"]["user"]
#   group node["airflow"]["group"]
#   files_owner node["airflow"]["user"]
#   files_group node["airflow"]["group"]
#   action :create
# end
