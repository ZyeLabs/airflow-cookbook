#
# Cookbook:: airflow
# Recipe:: account
#
# Copyright:: 2019, The Authors, All Rights Reserved.

node['airflow']['authorized_keys'].each do |entry|
  ssh_authorized_keys "remote-ssh-#{entry[:name]}" do
      user 'airflow'
      key entry[:key]
      type 'ssh-rsa'
      comment entry[:name]
    end
end

# Activate airflow virtual environment
execute "airflow-env-activate" do
  command "echo 'source #{node["airflow"]["install_path_current"]}/venv/bin/activate airflow' >> #{node["airflow"]["user_home_directory"]}/.bashrc"
  not_if "grep -q -i -e 'source #{node["airflow"]["install_path_current"]}/venv/bin/activate' #{node["airflow"]["user_home_directory"]}/.bashrc"
end

execute "airflow-home" do
  command "echo 'export AIRFLOW_HOME=#{node['airflow']['home_current']}' >> #{node["airflow"]["user_home_directory"]}/.bashrc"
  not_if "grep -q -i -e 'AIRFLOW_HOME=#{node['airflow']['home_current']}' #{node["airflow"]["user_home_directory"]}/.bashrc"
end

# set AIRFLOW_HOME env
execute "airflow-home" do
  command "echo 'cd #{node['airflow']['home_current']}' >> #{node["airflow"]["user_home_directory"]}/.bashrc"
  not_if "grep -q -i -e 'cd #{node['airflow']['home_current']}' #{node["airflow"]["user_home_directory"]}/.bashrc"
end

# set required env variable where the airflow kerberos ticket is stored (ccache)
execute "krb-cache-file" do
  command "echo 'export KRB5CCNAME=#{node['airflow']["config"]["kerberos"]["ccache"]}' >> #{node["airflow"]["user_home_directory"]}/.bashrc"
  not_if "grep -q -i -e 'KRB5CCNAME=#{node['airflow']["config"]["kerberos"]["ccache"]}' #{node["airflow"]["user_home_directory"]}/.bashrc"
end

# activate command auto-complete
execute "airflow-argcomplete" do
  command "echo 'eval \"$(register-python-argcomplete airflow)\"' >> #{node["airflow"]["user_home_directory"]}/.bashrc"
  not_if "grep -q -i -e 'register-python-argcomplete' #{node["airflow"]["user_home_directory"]}/.bashrc"
end

