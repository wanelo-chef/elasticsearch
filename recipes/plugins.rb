#
# Cookbook Name:: elasticsearch
# Recipe:: plugins
#
# Copyright (C) 2014 Wanelo, Inc.
#

node['elasticsearch']['plugins'].each do |plugin_name, plugin_repo|
  execute "/opt/local/bin/plugin --install #{plugin_repo}" do
    not_if "JAVA_HOME=#{node['elasticsearch']['java_home']} /opt/local/bin/plugin --list | grep #{plugin_name}"
    environment 'JAVA_HOME' => node['elasticsearch']['java_home']
  end
end
