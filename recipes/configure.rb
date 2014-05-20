#
# Cookbook Name:: elasticsearch
# Recipe:: configure
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'

master_hosts = search(:node, 'roles:elasticsearch-master')

template '/opt/local/etc/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  variables(
    master_hosts: master_hosts,
  )

  notifies :restart, 'service[elasticsearch]'
end
