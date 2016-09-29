#
# Cookbook Name:: project_name
# Recipe:: default
#

include_recipe 'chef-sugar::default'

ref = lambda { |h| "{{ cookiecutter.cookbook_name }}-#{h}" }

packages = [node.{{ cookiecutter.cookbook_name }}.package.keys()].flatten
services = [node.{{ cookiecutter.cookbook_name }}.service.keys()].flatten

packages.each do |pkg|

  package ref.call(pkg) do
    # required package attributes
    package_name node.{{ cookiecutter.cookbook_name }}.package[pkg].package_name
    action node.{{ cookiecutter.cookbook_name }}.package[pkg].action
    # optional package attributes
    services.each do |svc_ref|
      notifies :restart, "service[#{ref.call(svc_ref)}]", :delayed
    end
    {%
      for item in cookiecutter._chef.package.attributes:
    -%}
    {{ item }} node.{{ cookiecutter.cookbook_name }}.package[pkg].{{ item }} if node.deep_fetch("{{ cookiecutter.cookbook_name }}.package.#{pkg}.{{ item }}".split('.'))
    {%
      endfor
  -%}
  end
end

services.each do |svc|

  # manage each service
  service ref.call(svc) do
    # required service attributes
    action node.{{ cookiecutter.cookbook_name }}.service[svc].action
    service_name node.{{ cookiecutter.cookbook_name }}.service[svc].service_name
    # optional service attributes
    {%
      for item in cookiecutter._chef.service.attributes:
    -%}
    {{ item }} node.{{ cookiecutter.cookbook_name }}.service[svc].{{ item }} if node.deep_fetch("{{ cookiecutter.cookbook_name }}.service.#{svc}.{{ item }}".split('.'))
    {%
      endfor
  -%}
  end

end
