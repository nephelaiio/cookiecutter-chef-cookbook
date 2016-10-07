# user modifyable parameters
default['{{ cookiecutter.cookbook_name }}']['manage']['packages'] = true
default['{{ cookiecutter.cookbook_name }}']['manage']['services'] = true
default['{{ cookiecutter.cookbook_name }}']['manage']['config'] = false
default['{{ cookiecutter.cookbook_name }}']['package']['{{ cookiecutter.cookbook_name }}']['package_name'] = '{{ cookiecutter.cookbook_name }}'
default['{{ cookiecutter.cookbook_name }}']['package']['{{ cookiecutter.cookbook_name }}']['action'] = :install
default['{{ cookiecutter.cookbook_name }}']['service']['{{ cookiecutter.cookbook_name }}']['service_name'] = '{{ cookiecutter.cookbook_name }}'
default['{{ cookiecutter.cookbook_name }}']['service']['{{ cookiecutter.cookbook_name }}']['action'] = [:enable,:start]
default['{{ cookiecutter.cookbook_name }}']['config']['{{ cookiecutter.cookbook_name }}.conf']['path'] = '/etc/{{ cookiecutter.cookbook_name }}/{{ cookiecutter.cookbook_name }}.conf'
default['{{ cookiecutter.cookbook_name }}']['config']['{{ cookiecutter.cookbook_name }}.conf']['source'] = '{{ cookiecutter.cookbook_name }}.conf.erb'
