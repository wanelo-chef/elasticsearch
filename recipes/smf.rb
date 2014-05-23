#
# Cookbook Name:: elasticsearch
# Recipe:: smf
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'smf'
include_recipe 'elasticsearch::service'

smf 'pkgsrc/elasticsearch' do
  action :delete
end

smf 'elasticsearch' do
  start_command '/opt/local/bin/elasticsearch -d -Xms%{min_heap} -Xmx%{max_heap} -Des.index.store.type=%{store_type}'
  refresh_command ':kill -HUP'
  start_timeout 60
  stop_timeout 60
  refresh_timeout 60

  project 'elastic'
  user 'elastic'
  group 'elastic'
  working_directory '/var/tmp/elasticsearch'

  environment 'PATH' => '/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin',
              'JAVA_HOME' => '/opt/local/java/openjdk7'

  property_groups({
    'application' => {
      'min_heap' => node['elasticsearch']['min_heap'],
      'max_heap' => node['elasticsearch']['max_heap'],
      'store_type' => 'niofs'
    }
  })

  notifies :restart, 'service[elasticsearch]'
end
