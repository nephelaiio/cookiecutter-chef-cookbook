#
# Cookbook Name:: project_name
# Recipe:: default
#

[node.package.names].flatten.each do |pkg|
  package pkg do
    action node.package.action
  end
end
