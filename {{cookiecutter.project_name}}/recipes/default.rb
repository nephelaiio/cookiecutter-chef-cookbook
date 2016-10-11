#
# Cookbook Name:: project_name
# Recipe:: default
#

include_recipe '{{ cookiecutter._cookbook_name }}::packages'
include_recipe '{{ cookiecutter._cookbook_name }}::services'
include_recipe '{{ cookiecutter._cookbook_name }}::config'
