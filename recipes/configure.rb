#
# Cookbook Name:: elasticsearch
# Recipe:: configure
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'
include_recipe 'elasticsearch::cpu'

elasticsearch_hosts = search(:node, node['elasticsearch']['search'])

directory '/opt/local/etc/elasticsearch'

template '/opt/local/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  variables(
    elasticsearch_hosts: elasticsearch_hosts,
    master: node['elasticsearch']['master'],
    data: node['elasticsearch']['data'],
    cluster: node['elasticsearch']['cluster'],
    node_name: node['elasticsearch']['name'] || node.name,
    minimum_master_nodes: node['elasticsearch']['minimum_master_nodes'],
    processors: node['elasticsearch']['processors'],
    additional_config: node['elasticsearch']['additional_config'],
    http_cors_allow_origin: node['elasticsearch']['http_cors_allow_origin']
  )
end

template '/opt/local/etc/elasticsearch/logging.yml' do
  source 'logging.yml.erb'
  variables(
    syslog_enabled: node['elasticsearch']['syslog']['enabled'],
    syslog_server: node['elasticsearch']['syslog']['server'],
    syslog_port: node['elasticsearch']['syslog']['port'],
    syslog_facility: node['elasticsearch']['syslog']['facility'],
    syslog_log_format: node['elasticsearch']['syslog']['log_format'],
    keep: node['elasticsearch']['log_rotation']['keep']
  )
end
