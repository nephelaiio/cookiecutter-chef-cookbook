#
# Cookbook Name:: project_name
# Recipe:: config
#

ref = lambda { |h| "{{ cookiecutter.cookbook_name }}-#{h}" }

services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten
configs = [node['{{ cookiecutter.cookbook_name }}']['config'].keys()].flatten

configs.each do |cfg|
    template ref.call(cfg) do
        # required template attributes
        path                node['{{ cookiecutter.cookbook_name }}']['service'][cfg]['path']
        source              node['{{ cookiecutter.cookbook_name }}']['service'][cfg]['source']
        # service notifications
        services.each do |svc|
            notifies :restart, "service[#{ref.call(svc)}]", :delayed
        end
    end
end

ruby_block "config-options" do
    block do
        templates = [node['{{ cookiecutter.cookbook_name }}']['config'].keys()].flatten
        templates.each do |tpl|
            optional_attributes = node['{{ cookiecutter.cookbook_name }}']['config'][tpl].keys() - ['path', 'source']
            template_ref = run_context.resource_collection.find(:template => ref.call(tpl))
            optional_attributes.each do |attr|
                attribute_value = node['{{ cookiecutter.cookbook_name }}']['config'][tpl][attr]
                if attribute_value then
                    attribute_ref = template_ref.method(attr)
                    attribute_ref.call(attribute_value)
                end
            end
        end
    end
end
