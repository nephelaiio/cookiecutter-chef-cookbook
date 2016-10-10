#
# Cookbook Name:: project_name
# Recipe:: packages
#

ref = lambda { |h| "{{ cookiecutter.cookbook_name }}-#{h}" }

packages = [node['{{ cookiecutter.cookbook_name }}']['package'].keys()].flatten
services = [node['{{ cookiecutter.cookbook_name }}']['service'].keys()].flatten

packages.each do |pkg|
    package ref.call(pkg) do
        # required package attributes
        package_name      node['{{ cookiecutter.cookbook_name }}']['package'][pkg]['package_name']
        action            node['{{ cookiecutter.cookbook_name }}']['package'][pkg]['action']
        # service notifications
        services.each do |svc|
            notifies :restart, "service[#{ref.call(svc)}]", :delayed
        end
    end
end

ruby_block "package-options" do 
    block do
        packages = [node['{{ cookiecutter.cookbook_name }}']['package'].keys()].flatten
        packages.each do |pkg|
            optional_attributes = node['{{ cookiecutter.cookbook_name }}']['package'][pkg].keys() - ['package_name', 'action']
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
