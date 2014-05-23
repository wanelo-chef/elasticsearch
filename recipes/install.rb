#
# Cookbook Name:: elasticsearch
# Recipe:: install
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'

package 'elasticsearch' do
  notifies :enable, 'service[elasticsearch]'
  notifies :start, 'service[elasticsearch]'
end

include_recipe 'elasticsearch::smf'
