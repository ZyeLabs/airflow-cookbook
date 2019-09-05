#
# Cookbook:: airflow
# Recipe:: connections
#
# Copyright:: 2019, The Authors, All Rights Reserved.


airflow_exec = ::File.join(node["airflow"]["install_path"],"bin/airflow")

bash "beeline-hive-connection" do
  user node["airflow"]["user"]
  cwd node["airflow"]["install_path"]
  environment(
    'AIRFLOW_HOME' => node["airflow"]["home"]
  )
  code <<-EOH
    #{airflow_exec} connections --add \
    --conn_id beeline_hive \
    --conn_type 'beeline' \
    --conn_host 'lxdphdpu01.cellc.net' \
    --conn_port 10000 \
    --conn_extra '{\"use_beeline\": true, \"auth\":\"kerberos;principal=airflow/lxdphdfu01.cellc.net@CELLC.NET;\"}'
  EOH
  not_if "AIRFLOW_HOME=#{node["airflow"]["home"]} #{airflow_exec} connections -l |& grep -qie beeline_hive"
end