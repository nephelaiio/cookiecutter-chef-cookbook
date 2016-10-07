#
# Cookbook Name:: project_name
# Recipe:: default
#

include_recipe 'chef-sugar::default'

def safe_fetch(spec)
  def safe_fetch_recurse(obj, spec)
    if spec == [] then
      obj
    else
      head, *tail = spec
      if obj.has_key?(head) then
        safe_fetch_recurse(obj[head], tail)
      else
        nil
      end
    end
  end
  safe_fetch_helper(node, spec.split('.'))
end

ref = lambda { |h| "{{ cookiecutter.cookbook_name }}-#{h}" }

packages = [node['{{ cookiecutter.cookbook_name }}']['package'].keys()].flatten
services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten
configs = [node['{{ cookiecutter.cookbook_name }}']['config'].keys()].flatten

if node['{{ cookiecutter.cookbook_name }}']['manage']['packages'] then

  packages.each do |pkg|

    package ref.call(pkg) do
      # required package attributes
      package_name      node['{{ cookiecutter.cookbook_name }}']['package'][pkg]['package_name']
      action            node['{{ cookiecutter.cookbook_name }}']['package'][pkg]['action']
      # service notifications
      if node['{{ cookiecutter.cookbook_name }}']['manage']['services'] then
        services.each do |svc_ref|
          notifies :restart, "service[#{ref.call(svc_ref)}]", :delayed
        end
      end
      # optional package attributes
      ignore_failure    lazy { safe_fetch('{{ cookiecutter.cookbook_name }}.package.#{pkg}.ignore_failure') or false }
    end

  end

end

if node['{{ cookiecutter.cookbook_name }}']['manage']['services'] then

  services.each do |svc|

    service ref.call(svc) do
      # required service attributes
      action              node['{{ cookiecutter.cookbook_name }}']['service'][svc]['action']
      service_name        node['{{ cookiecutter.cookbook_name }}']['service'][svc]['service_name']
      # optional service attributes
    end

  end

end
