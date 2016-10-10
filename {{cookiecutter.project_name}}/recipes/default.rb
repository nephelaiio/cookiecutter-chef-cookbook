#
# Cookbook Name:: project_name
# Recipe:: default
#

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
        end
    end
end

ruby_block "package-options" do 
    block do
        manage = node['{{ cookiecutter.cookbook_name }}']['manage']['packages'] 
        if manage then
            packages = [node['{{ cookiecutter.cookbook_name }}']['package'].keys()].flatten
            packages.each do |pkg|
                optional_attributes = node['{{ cookiecutter.cookbook_name }}']['package'][pkg].keys()
                package_ref = run_context.resource_collection.find(:package => ref.call(pkg))
                optional_attributes.each do |attr|
                    attribute_value = node['{{ cookiecutter.cookbook_name }}']['package'][pkg][attr]
                    if attribute_value then
                        attribute_ref = package_ref.method(attr)
                        attribute_ref.call(attribute_value)
                    end
                end
            end
        end
    end
end

if node['{{ cookiecutter.cookbook_name }}']['manage']['services'] then
    services.each do |svc|
        service ref.call(svc) do
            # required service attributes
            action              node['{{ cookiecutter.cookbook_name }}']['service'][svc]['action']
            service_name        node['{{ cookiecutter.cookbook_name }}']['service'][svc]['service_name']
        end
    end
end

ruby_block "service-options" do 
    block do
        manage = node['{{ cookiecutter.cookbook_name }}']['manage']['services'] 
        if manage then
            services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten
            services.each do |svc|
                optional_attributes = node['{{ cookiecutter.cookbook_name }}']['service'][svc].keys()
                # optional service attributes
                service_ref = run_context.resource_collection.find(:service => ref.call(svc))
                optional_attributes.each do |attr|
                    attribute_value = node['{{ cookiecutter.cookbook_name }}']['service'][svc][attr]
                    if attribute_value then
                        attribute_ref = service_ref.method(attr)
                        attribute_ref.call(attribute_value)
                    end
                end
            end
        end
    end
end
