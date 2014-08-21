#
# Cookbook Name:: elasticsearch
# Recipe:: install
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'java::default'

version = node['elasticsearch']['version']
tar_file = "elasticsearch-#{version}.tar.gz"

remote_file "#{Chef::Config[:file_cache_path]}/#{tar_file}" do
  source "#{node['elasticsearch']['mirror']}/#{tar_file}"
  checksum node['elasticsearch']['checksum']
  mode 0755

  action :create
  notifies :run, "execute[untar #{tar_file}]", :immediately
end

execute "untar #{tar_file}" do
  command <<-EOC
    mkdir -p /opt/elasticsearch \
    && cd /opt/elasticsearch \
    && tar -xzf #{Chef::Config[:file_cache_path]}/#{tar_file}
  EOC
  environment 'PATH' => node['paths']['bin_path']
  notifies :create, 'link[/opt/local/lib/elasticsearch]', :immediately
  action :nothing
end

link '/opt/local/lib/elasticsearch' do
  to "/opt/elasticsearch/elasticsearch-#{version}/lib"
  notifies :restart, 'service[elasticsearch]'
  action :nothing
end

template '/opt/local/bin/elasticsearch.in.sh' do
  source 'elasticsearch.in.sh.erb'
  mode 0755
  notifies :restart, 'service[elasticsearch]'
  variables newrelic: node['elasticsearch']['newrelic'],
            elasticsearch_version: version,
            max_perm_size: node['elasticsearch']['max_perm_size']
end

template '/opt/local/bin/elasticsearch' do
  source 'elasticsearch.erb'
  mode 0755
  notifies :restart, 'service[elasticsearch]'
end

template '/opt/local/bin/plugin' do
  source 'plugin.erb'
  mode 0755
  notifies :restart, 'service[elasticsearch]'
end

include_recipe 'elasticsearch::service'
