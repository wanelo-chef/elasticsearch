#
# Cookbook Name:: elasticsearch
# Recipe:: memory
#
# Copyright (C) 2014 Wanelo, Inc.
#

class Chef::Recipe
  include MemoryHelper
end

# take half available ram, or 30GB whichever is smaller
heap_size_value = "#{recommended_ram_mb}m"

node.default['elasticsearch']['min_heap'] = heap_size_value
node.default['elasticsearch']['max_heap'] = heap_size_value
