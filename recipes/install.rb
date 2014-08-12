#
# Cookbook Name:: elasticsearch
# Recipe:: install
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'java::default'

package 'elasticsearch' do
  version '1.3.0'
  notifies :enable, 'service[elasticsearch]'
  notifies :start, 'service[elasticsearch]'
end

template '/opt/local/bin/elasticsearch.in.sh' do
  source 'elasticsearch.in.sh.erb'
  mode 0755
  notifies :restart, 'service[elasticsearch]'
  variables(:newrelic => node[:elasticsearch][:newrelic])
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
