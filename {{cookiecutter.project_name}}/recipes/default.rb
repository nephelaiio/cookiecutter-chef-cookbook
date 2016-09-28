#
# Cookbook Name:: project_name
# Recipe:: default
#

[node.{{ cookiecutter.cookbook_name }}.package.names].flatten.each do |pkg|
  package pkg do
    action node.{{ cookiecutter.cookbook_name }}.package.action
  end
end
