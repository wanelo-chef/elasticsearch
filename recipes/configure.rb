#
# Cookbook Name:: elasticsearch
# Recipe:: configure
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'

elasticsearch_hosts = search(:node, node['elasticsearch']['search'])

template '/opt/local/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  variables(
    elasticsearch_hosts: elasticsearch_hosts,
    master: node['elasticsearch']['master'],
    cluster: node['elasticsearch']['cluster'],
    node_name: node['elasticsearch']['name'] || node.name,
    minimum_master_nodes: node['elasticsearch']['minimum_master_nodes'],
  )

  notifies :restart, 'service[elasticsearch]'
end
