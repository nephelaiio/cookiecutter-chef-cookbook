# user modifyable parameters
default['{{ cookiecutter.cookbook_name }}']['package']['{{ cookiecutter.cookbook_name }}']['package_name'] = '{{ cookiecutter.cookbook_name }}'
default['{{ cookiecutter.cookbook_name }}']['package']['{{ cookiecutter.cookbook_name }}']['action'] = :install
default['{{ cookiecutter.cookbook_name }}']['service']['{{ cookiecutter.cookbook_name }}']['service_name'] = '{{ cookiecutter.cookbook_name }}'
default['{{ cookiecutter.cookbook_name }}']['service']['{{ cookiecutter.cookbook_name }}']['action'] = [:enable,:start]
default['{{ cookiecutter.cookbook_name }}']['config'] = {}
