#
# Cookbook Name:: elasticsearch
# Recipe:: memory
#
# Copyright (C) 2014 Wanelo, Inc.
#

class Chef::Recipe
  include CpuHelper
end

node.default['elasticsearch']['processors'] = number_of_processors
