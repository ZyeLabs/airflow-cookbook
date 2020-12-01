# Airflow cookbook changelog

## 1.2.1

 - Airflow package name support (default: apache-airflow)
 - Lazy config loading

## 1.2.0

 - Added ubuntu 16.04 support
 - Packages version pinning
 - Fixed python and pip installation
 - Bug fixes

## 1.1.0

 - Added CentOS support
 - Flower, kerberos and worker services
 - New airflow packages support

## 1.0.1

- Some foodcritic fixes
- README updated
- Fixed some minor attributes issues and cosmetics

## 1.0.0

- Initial release of airflow-cookbook

## 1.0.4

- add custom section in the packages list for our own required python packages
- make logs folder sharable between versions at the home_root dir

## 1.0.5

- include ssh sub-packages in the required packages to be installed

## 1.0.6

- set JAVA_TOOL_OPTIONS env variable in .bashrc for secure hive connection
- set JAVA_TOOL_OPTIONS env variable in airflow-env file as well
- generate SSH key pair for the airflow user
- lock community cookbook versions

## 1.0.7

- Enable rbac role-based authorisation
- Add webserver_config.py template for fab-based backend
- Refactor ldap attributes

## 1.0.8

- Add cron job to force restart scheduler per defined interval
- Improve service recipes to reload systemd upon modification

## 1.0.9

- Configure SMTP for emails

## 1.0.10

- Increase paralleism

