#
# Cookbook Name:: elasticsearch
# Recipe:: newrelic
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'

directory '/opt/local/newrelic'

template '/opt/local/newrelic/newrelic.yml' do
  source 'newrelic.yml.erb'
  variables(:newrelic => node[:elasticsearch][:newrelic])
  not_if { node[:elasticsearch][:newrelic][:api_key].to_s.empty? }
end

remote_file '/opt/local/newrelic/newrelic.jar' do
  source node[:elasticsearch][:newrelic][:jar_url]
  not_if { node[:elasticsearch][:newrelic][:api_key].to_s.empty? }
end

template '/opt/local/bin/elasticsearch.in.sh' do
  source 'elasticsearch.in.sh.erb'
  mode 0755
  notifies :restart, 'service[elasticsearch]'
  not_if { node[:elasticsearch][:newrelic][:api_key].to_s.empty? }
end
