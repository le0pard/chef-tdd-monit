#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright (C) 2013 Alexey Vasyliev
#
# All rights reserved - Do Not Redistribute
#

package "monit"

service "monit" do
  action [:enable, :start]
  supports [:start, :restart, :stop]
end

directory node[:monit][:includes_dir] do
  owner  'root'
  group 'root'
  mode 0755
  action :create
  recursive true
end

template node[:monit][:main_config_path] do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  notifies :restart, "service[monit]", :delayed
end
