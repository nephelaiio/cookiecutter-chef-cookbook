# {{ cookiecutter.cookbook_name }} cookbook
===========================================
Install and configure {{ cookiecutter.cookbook_target }}

## Requirements
* Chef 12.0.0 or higher
* Functional package repositories

## Platform Support
* CentOS 6
* CentOS 7

## Parameters
### Package attribute hash
For every package PKG_I, the following attributes are required:
- node['{{ cookiecutter.cookbook_name }}']['package'][PKG_I]['package_name'] - The name of the package to be installed
- node['{{ cookiecutter.cookbook_name }}']['package'][PKG_I]['action'] - Any combination of [:install, :nothing, :purge, :reconfig, :remove, :upgrade]
Additionally any other valid [package attribute](https://docs.chef.io/resource_package.html) can be optionally added in the same fashion
### Service attribute hash
For every service SVC_I, the following attributes are required:
- node['{{ cookiecutter.cookbook_name }}']['service'][SVC_I]['service_name'] - The name of the service to be managed
- node['{{ cookiecutter.cookbook_name }}']['service'][SVC_I]['action'] - Any combination of [:disable, :enable, :nothing, :reload, :restart, :start, :stop]
Additionally any other valid [service attribute](https://docs.chef.io/resource_service.html) can be optionally added in the same fashion
If the [services](/recipes/services.rb) is not included in the run list the service hash must be set to {} like so;
```
node['{{ cookiecutter.cookbook_name }}']['service'] = {}
```
### Configuration attribute hash
For every configuration file CFG_I, the following attributes are required:
- node['{{ cookiecutter.cookbook_name }}']['config'][CFG_I]['path'] - The name of the file to manage
- node['{{ cookiecutter.cookbook_name }}']['config'][CFG_I]['source'] - The name of the template to render
Additionally any other valid [template attribute](https://docs.chef.io/resource_template.html) can be optionally added in the same fashion

## Recipes
- [default](/recipes/default.rb) - An alias for the union of [packages, services, config]
- [packages](/recipes/packages.rb) - Package management resources
- [services](/recipes/services.rb) - Service management resources
- [config](/recipes/config.rb) - Configuration management resources

## License
This project is licensed under the terms of the [{{ cookiecutter.license }} License](/LICENSE)

