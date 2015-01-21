#
# Cookbook Name:: elasticsearch
# Recipe:: smf
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'smf'
include_recipe 'elasticsearch::memory'

smf 'pkgsrc/elasticsearch' do
  action :delete
end

elasticsearch_environment = {
  'PATH' => node['elasticsearch']['path'],
  'JAVA_BIN' => node['elasticsearch']['java_bin'],
  'JAVA_ENV' => node['elasticsearch']['java_env'],
  'JAVA_HOME' => node['elasticsearch']['java_home'],
  'LANG' => 'en_US.UTF-8',
  'LC_ALL' => 'en_US.UTF-8'
}.reject { |k, v| v.nil? }
elasticsearch_environment['ES_USE_GC_LOGGING'] = 1 if node['elasticsearch']['verbose_gc']
elasticsearch_environment['ES_USE_G1GC'] = 1 if node['elasticsearch']['garbage_collector'] == 'G1GC'

group 'elastic'

user 'elastic' do
  home '/nonexistent'
  comment 'ElasticSearch user'
  gid 'elastic'
  shell '/usr/bin/false'
  supports manage_home: false
end

resource_control_project 'elastic' do
  comment 'Elastic Search Service'
  users 'elastic'
  process_limits 'max-file-descriptor' => {
    'value' => 40000, 'deny' => true
  }
end

directory '/var/tmp/elasticsearch' do
  owner 'elastic'
  group 'elastic'
end

directory '/var/log/elasticsearch' do
  owner 'elastic'
  group 'elastic'
end

directory '/var/db/elasticsearch' do
  owner 'elastic'
  group 'elastic'
end

smf 'elasticsearch' do
  start_command '/opt/local/bin/elasticsearch -d -Xms%{min_heap} -Xmx%{max_heap} -Des.index.store.type=%{store_type}'
  start_timeout 60
  stop_timeout 60
  refresh_timeout 60

  privileges %w(basic net_privaddr proc_lock_memory)
  project 'elastic'
  user 'elastic'
  group 'elastic'
  working_directory '/var/tmp/elasticsearch'

  environment elasticsearch_environment

  property_groups({
    'application' => {
      'min_heap' => node['elasticsearch']['min_heap'],
      'max_heap' => node['elasticsearch']['max_heap'],
      'store_type' => node['elasticsearch']['store_type']
    }
  })

  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['restart_on_smf_change']
end

include_recipe 'elasticsearch::service'
