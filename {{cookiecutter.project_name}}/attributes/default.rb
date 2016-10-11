# user modifyable parameters
default['{{ cookiecutter._cookbook_name }}']['package']['{{ cookiecutter.cookbook_target }}']['package_name'] = '{{ cookiecutter.cookbook_target }}'
default['{{ cookiecutter._cookbook_name }}']['package']['{{ cookiecutter.cookbook_target }}']['action'] = :install
default['{{ cookiecutter._cookbook_name }}']['service']['{{ cookiecutter.cookbook_target }}']['service_name'] = '{{ cookiecutter.cookbook_target }}'
default['{{ cookiecutter._cookbook_name }}']['service']['{{ cookiecutter.cookbook_target }}']['action'] = [:enable,:start]
default['{{ cookiecutter._cookbook_name }}']['config'] = {}
