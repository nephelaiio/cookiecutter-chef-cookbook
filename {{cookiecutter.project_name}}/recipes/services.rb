# Cookbook Name:: project_name
# Recipe:: services
#

ref = lambda { |h| "{{ cookiecutter.cookbook_name }}-#{h}" }

services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten

services.each do |svc|
    service ref.call(svc) do
        # required service attributes
        service_name        node['{{ cookiecutter.cookbook_name }}']['service'][svc]['service_name']
        action              node['{{ cookiecutter.cookbook_name }}']['service'][svc]['action']
    end
end

ruby_block "service-options" do 
    block do
        manage = node['{{ cookiecutter.cookbook_name }}']['manage']['services'] 
        if manage then
            services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten
            services.each do |svc|
                optional_attributes = node['{{ cookiecutter.cookbook_name }}']['service'][svc].keys() - ['action', 'service_name']
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
