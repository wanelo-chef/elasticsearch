#
# Cookbook Name:: elasticsearch
# Recipe:: service
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::service'

service 'elasticsearch' do
  supports restart: true, reload: true, enable: true, disable: true
  action :nothing
end
