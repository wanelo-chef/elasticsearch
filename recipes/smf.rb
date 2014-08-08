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
  'PATH' => '/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin',
  'JAVA_HOME' => node['elasticsearch']['java_home']
}
elasticsearch_environment['ES_USE_GC_LOGGING'] = 1 if node['elasticsearch']['verbose_gc']
smf 'elasticsearch' do
  start_command '/opt/local/bin/elasticsearch -d -Xms%{min_heap} -Xmx%{max_heap} -Des.index.store.type=%{store_type}'
  start_timeout 60
  stop_timeout 60
  refresh_timeout 60

  project 'elastic'
  user 'elastic'
  group 'elastic'
  working_directory '/var/tmp/elasticsearch'

  environment elasticsearch_environment

  property_groups({
    'application' => {
      'min_heap' => node['elasticsearch']['min_heap'],
      'max_heap' => node['elasticsearch']['max_heap'],
      'store_type' => 'niofs'
    }
  })

  notifies :restart, 'service[elasticsearch]'
end

include_recipe 'elasticsearch::service'
