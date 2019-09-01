# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

resource_name :pip_package

require 'chef/mixin/shell_out'

property :package_name, String, name_property: true, required: true
property :version, String, default: ''
property :virtualenv, String, default: ''
property :user, String, default: "root"
property :group, String, default: "root"
property :virtualenv, String, default: ""


action :install do

  if !is_installed(new_resource.user, new_resource.virtualenv, new_resource.package_name)
    install_package(
      new_resource.user,
      new_resource.group,
      new_resource.virtualenv,
      new_resource.package_name,
      new_resource.version
    )
  elsif !version_constraints_satisfied(new_resource.user, new_resource.virtualenv, new_resource.package_name, new_resource.version)
    # first remove the package
    python_package "remove-package-#{new_resource.package_name}" do
      package_name new_resource.package_name
      user new_resource.user
      group  new_resource.group
      virtualenv new_resource.virtualenv
      action :remove
    end
    # reinstall the package
    install_package(
      new_resource.user,
      new_resource.group,
      new_resource.virtualenv,
      new_resource.package_name,
      new_resource.version
    )
  end
end

action_class do
  def is_installed(user, virtualenv, package_name)
   exit_code = shell_out("sudo -u #{user} sh -c \"#{virtualenv}/bin/pip show #{package_name} >/dev/null 2>&1\"; echo $?").stdout.strip.to_i
   return exit_code == 0
  end

  def current_version(user, virtualenv, package_name)
    shell_out("sudo -u #{user} sh -c \"#{virtualenv}/bin/pip show #{package_name} |& grep -i ^version\" | awk '{print $2}'").stdout.strip
  end

  def version_constraints_satisfied(user, virtualenv, package_name, version_str)
    current_version = current_version(user, virtualenv, package_name)
    version_args = version_str.split(',').map(&:strip)
    versions =
      version_args.each.map do |version_arg|
        operator = ((value = version_arg.split(/\d+/).first).empty? ? "==" : value)
        target = version_arg.split(operator).last
        { operator: operator, version: target }
      end
    results = []
    versions.each do |item|
      results << Gem::Version.new(current_version).public_send(item[:operator],Gem::Version.new(item[:version]))
    end
    return !results.include?(false)
  end

  def install_package(user, group, virtualenv, package_name, version_str)
    python_package "install-package-#{package_name}" do
      package_name package_name
      version version_str
      user user
      group  group
      virtualenv virtualenv
      action :install
    end
  end
end