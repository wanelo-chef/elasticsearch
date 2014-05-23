#
# Cookbook Name:: elasticsearch
# Recipe:: service
#
# Copyright (C) 2014 Wanelo, Inc.
#

service 'elasticsearch' do
  supports restart: true, reload: true, enable: true, disable: true
  action :nothing
end
