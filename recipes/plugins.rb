#
# Cookbook Name:: elasticsearch
# Recipe:: plugins
#
# Copyright (C) 2014 Wanelo, Inc.
#

node['elasticsearch']['plugins'].each do |plugin|
  execute "/opt/local/bin/plugin --install #{plugin}" do
    not_if "/opt/local/bin/plugin --list | grep #{plugin}"
  end
end
