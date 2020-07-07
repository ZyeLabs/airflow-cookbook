# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http//www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Core packages - built to match the Setup.py file in the Aiflow repository.
# default['airflow']['packages'] = ['async', 'crypto', 'hdfs', 'hive', 'jdbc', 'kerberos',
                                  # 'ldap', 'postgres']

# Core packages - built to match the Setup.py file in the Aiflow repository.
# The (*) and (~=) characters in the version strings are not compatible in this script, and have to be replaced with equivalents
# examples:
# ~=4.3 must be replaced with (>=4.3, <5.0)
# ~=1.6.2 must be replaced with (>=1.6.2, < 1.7.0)
default['airflow']['packages'] =
  {
    async: [{ name: 'greenlet', version: '>=0.4.9' },
            { name: 'eventlet', version: '>=0.9.7' },
            { name: 'gevent', version: '>=0.13' }],
    atlas: [{ name: 'atlasclient', version: '>=0.1.2' }],
    azure_blob_storage: [{ name: 'azure-storage', version: '>=0.34.0' }],
    azure_data_lake: [{ name: 'azure-mgmt-resource', version: '>=2.2.0' },
                      { name: 'azure-mgmt-datalake-store', version: '>=0.5.0' },
                      { name: 'azure-datalake-store', version: '>=0.0.45' }],
    azure_cosmos: [{ name: 'azure-cosmos', version: '>=3.0.1' }],
    azure_container_instances: [{ name: 'azure-mgmt-containerinstance', version: '>=1.5.0' }],
    cassandra: [{ name: 'cassandra-driver>', version: '>=3.13.0' }],
    celery: [{ name: 'celery', version: '>=4.3, <5.0' },
             { name: 'flower', version: '>=0.7.3, <1.0' },
             { name: 'tornado', version: '>=4.2.0, <6.0' }],
    cgroups: [{ name: 'cgroupspy', version: '>=0.1.4' }],
    cloudant: [{ name: 'cloudant', version: '>=0.5.9,<2.0' }],
    crypto: [{ name: 'cryptography', version: '>=0.9.3' }],
    dask: [{ name: 'distributed', version: '>=1.17.1, <2' }],
    databricks: [{name: 'requests', version: '>=2.20.0, <3' }],
    datadog: [{ name: 'datadog', version: '>=0.14.0' }],
    doc: [{ name: 'sphinx', version: '>=1.2.3' },
          { name: 'sphinx-argparse', version: '>=0.1.13' },
          { name: 'sphinx-autoapi', version: '==1.0.0' },
          { name: 'sphinx-rtd-theme', version: '>=0.1.6' },
          { name: 'sphinxcontrib-httpdomain', version: '>=1.7.0' }],
    docker: [{ name: 'docker', version: '>=3.0, <4.0' }],
    druid: [{ name: 'druid', version: '>=0.4.1' }],
    elasticsearch: [{ name: 'elasticsearch', version: '>=5.0.0,<6.0.0' },
                    { name: 'elasticsearch-dsl', version: '>=5.0.0,<6.0.0' }],
    emr: [{ name: 'boto3', version: '>=1.0.0, <1.8.0' }],
    gcp: [{ name: 'google-api-python-client', version: '>=1.6.0, <2.0.0dev' },
          { name: 'google-auth-httplib2', version: '>=0.0.1' },
          { name: 'google-auth', version: '>=1.0.0, <2.0.0dev' },
          { name: 'google-cloud-bigtable', version: '==0.33.0' },
          { name: 'google-cloud-container', version: '>=0.1.1' },
          { name: 'google-cloud-dlp', version: '>=0.11.0' },
          { name: 'google-cloud-language', version: '>=1.1.1' },
          { name: 'google-cloud-spanner', version: '>=1.7.1, <1.10.0' },
          { name: 'google-cloud-storage', version: '>=1.16, <2.0' },
          { name: 'google-cloud-translate', version: '>=1.3.3' },
          { name: 'google-cloud-videointelligence', version: '>=1.7.0' },
          { name: 'google-cloud-vision', version: '>=0.35.2' },
          { name: 'google-cloud-texttospeech', version: '>=0.4.0' },
          { name: 'google-cloud-speech', version: '>=0.36.3' },
          { name: 'grpcio-gcp', version: '>=0.2.2' },
          { name: 'httplib2', version: '>=0.9.2, <0.10.0' },
          { name: 'pandas-gbq', version: '' },
          { name: 'PyOpenSSL', version: '' }],
    grpc: [{ name: 'grpcio', version: '>=1.15.0' }],
    flask_oauth: [{ name: 'Flask-OAuthlib', version: '>=0.9.1' },
                  { name: 'oauthlib', version: '!=2.0.3,!=2.0.4,!=2.0.5,<3.0.0,>=1.1.2' },
                  { name: 'requests-oauthlib', version: '==1.1.0' }],
    hdfs: [{ name: 'snakebite', version: '>=2.7.8' }],
    hive: [{ name: 'hmsclient', version: '>=0.1.0' },
           { name: 'pyhive', version: '>=0.6.0' }],
    jdbc: [{ name: 'jaydebeapi', version: '>=1.1.1' }],
    jenkins: [{ name: 'python-jenkins', version: '>=1.0.0' }],
    jira: [{ name: 'JIRA', version: '>1.0.7'}],
    kerberos: [{ name: 'pykerberos', version: '>=1.1.13' },
               { name: 'requests_kerberos', version: '>=0.10.0' },
               { name: 'thrift_sasl', version: '>=0.2.0' },
               { name: 'snakebite[kerberos]', version: '>=2.7.8' }],
    kubernetes: [{ name: 'kubernetes', version: '>=3.0.0' },
                 { name: 'cryptography', version: '>=2.0.0' }],
    ldap: [{ name: 'ldap3', version: '>=2.5.1' }],
    mssql: [{ name: 'pymssql', version: '>=2.1.1' }],
    mysql: [{ name: 'mysqlclient', version: '>=1.3.6,<1.4' }],
    oracle: [{ name: 'cx_Oracle', version: '>=5.1.2' }],
    password: [{ name: 'bcrypt', version: '>=2.0.0' },
               { name: 'flask-bcrypt', version: '>=0.7.1' }],
    pinot: [{ name: 'pinotdb', version: '==0.1.1' }],
    postgres: [{ name: 'psycopg2', version: '>=2.7.4,<2.8' }],
    qds: [{ name: 'qds-sdk', version: '>=1.10.4' }],
    rabbitmq: [{ name: 'librabbitmq', version: '>=1.6.1' }],
    redis: [{ name: 'redis', version: '>=3.2, <4.0'}],
    s3: [{ name: 'boto3', version: '>=1.7.0, <1.8.0' }],
    salesforce: [{name: 'simple-salesforce', version: '>=0.72'}],
    samba: [{ name: 'pysmbclient', version: '>=0.1.3' }],
    segment: [{ name: 'analytics-python', version: '>=1.2.9' }],
    sendgrid: [{ name: 'sendgrid', version: '>=5.2.0,<6' }],
    slack: [{ name: 'slackclient', version: '>=1.0.0,<2.0.0' }],
    mongo: [{ name: 'pymongo', version: '>=3.6.0' },
            { name: 'dnspython', version: '>=1.13.0,<2.0.0' }],
    snowflake: [{ name: 'snowflake-connector-python', version: '>=1.5.2' },
                { name: 'snowflake-sqlalchemy', version: '>=1.1.0' }],
    ssh: [{ name: 'paramiko', version: '>=2.1.1' },
          { name: 'pysftp', version: '>=0.2.9' },
          { name: 'sshtunnel', version: '>=0.1.4,<0.2' }],
    statsd: [{ name: 'statsd', version: '>=3.0.1, <4.0' }],
    vertica: [{ name: 'vertica-python', version: '>=0.5.1' }],
    virtualenv: [{ name: 'virtualenv', version: '' }],
    #removed version condition from webhdfs, since it throws error in subsequent chef-runs after installation
    # ArgumentError: Malformed version number string >=2.0.4
    webhdfs: [{ name: 'hdfs[dataframe,avro,kerberos]', version: '' }],
    winrm: [{ name: 'pywinrm', version: '==0.2.2' }],
    zendesk: [{ name: 'zdesk', version: '' }],
    devel: [
            { name: 'beautifulsoup4', version: '>=4.7.1, <4.8.0' },
            { name: 'click', version: '==6.7' },
            { name: 'codecov', version: '' },
            { name: 'contextdecorator', version: '<3.4' },
            { name: 'flake8', version: '>=3.6.0' },
            { name: 'flake8-colors', version: '' },
            { name: 'freezegun', version: '' },
            { name: 'ipdb', version: '' },
            { name: 'jira', version: '' },
            { name: 'mock', version: '' },
            { name: 'lxml', version: '>=3.3.4' },
            { name: 'mock', version: '<3.3' },
            { name: 'mongomock', version: '' },
            { name: 'moto', version: '==1.3.5' },
            { name: 'nose', version: '' },
            { name: 'nose-ignore-docstring', version: '==0.2' },
            { name: 'nose-timer', version: '' },
            { name: 'parameterized', version: '' },
            { name: 'paramiko', version: '' },
            { name: 'pysftp', version: '' },
            { name: 'pywinrm', version: '' },
            { name: 'qds-sdk', version: '>=1.9.6' },
            { name: 'rednose', version: '' },
            { name: 'requests_mock', version: '' },
            { name: 'requests_mock', version: '' }],
    # our custom development required packages
    custom: [{ name: 'paramiko', version: '' }]
  }

if node["airflow"]["python_runtime"].to_i == 3
  default['airflow']['packages'][:devel] << { name: 'mypy', version: '' }
  # snakebite library is not supported in Python 3
  default['airflow']['packages'][:kerberos].delete_if { |item| item[:name] == "snakebite[kerberos]" }
  default['airflow']['packages'][:hdfs].delete_if { |item| item[:name] == "snakebite" }
end

# OS packages needed for the above python packages.
default['airflow']['dependencies'] =
  {
    ubuntu:
    {
      default: [{ name: 'python-dev', version: '' },
                { name: 'build-essential', version: '' },
                { name: 'libssl-dev', version: '' }],
      mysql: [{ name: 'mysql-client', version: '' },
              { name: 'libmysqlclient-dev', version: '' }],
      postgres: [{ name: 'postgresql-client', version: '' },
                 { name: 'libpq-dev', version: '' }],
      mssql: [{ name: 'freetds-dev', version: '' }],
      crypto: [{ name: 'libffi-dev', version: '' }],
      password: [{ name: 'libffi-dev', version: '' }],
      gcp_api: [{ name: 'libffi-dev', version: '' }],
      ldap: [{ name: 'libldap2-dev', version: '' }],
      hive: [{ name: 'libsasl2-dev', version: '' }],
      devel_hadoop: [{ name: 'libkrb5-dev', version: '' }],
      webhdfs: [{ name: 'libkrb5-dev', version: '' }],
      kerberos: [{ name: 'libsasl2-dev', version: '' }]
    },
    centos:
    {
      default: [{ name: 'gcc', version: '' },
                { name: 'gcc-c++', version: '' },
                { name: 'epel-release', version: '' },
                { name: 'libffi-devel', version: '' },
                { name: 'zlib-devel', version: '' },
                { name: 'python-devel', version: '' }],
      mysql: [{ name: 'mariadb', version: '' },
              { name: 'mariadb-devel', version: '' }],
      postgres: [{ name: 'postgresql', version: '' },
                 { name: 'postgresql-devel', version: '' }],
      mssql: [{ name: 'freetds-devel', version: '' }],
      crypto: [{ name: 'libffi-devel', version: '' }],
      password: [{ name: 'libffi-devel', version: '' }],
      gcp: [{ name: 'libffi-devel', version: '' }],
      ldap: [{ name: 'cyrus-sasl-devel', version: '' }],
      hive: [{ name: 'cyrus-sasl-devel', version: '' }],
      devel_hadoop: [{ name: 'cyrus-sasl-devel', version: '' }],
      webhdfs: [{ name: 'cyrus-sasl-devel', version: '' }],
      kerberos: [{ name: 'cyrus-sasl-devel', version: '' },
                { name: 'cyrus-sasl-gssapi', version: '' },
                { name: 'krb5-devel', version: '' }]
    }
  }
 # cyrus-sasl-gssapi was added as a requirement for connecting to kerberized service such as hive metastore using GSSAPI auth protocol.


if node["airflow"]["python_runtime"].to_i == 3
  default['airflow']['dependencies'][:ubuntu][:default].delete_if { |item| item[:name] == "python-dev" }
  default['airflow']['dependencies'][:ubuntu][:default] << { name: "python#{node["airflow"]["python_version"]}-dev", version: '' }

  default['airflow']['dependencies'][:centos][:default].delete_if { |item| item[:name] == "python-devel" }
  default['airflow']['dependencies'][:centos][:default] << { name: "python3", version: '' }
  default['airflow']['dependencies'][:centos][:default] << { name: "python3-devel", version: '' }
end
