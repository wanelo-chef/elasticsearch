#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 Wanelo, Inc.
#

include_recipe 'elasticsearch::install'
include_recipe 'elasticsearch::plugins'
include_recipe 'elasticsearch::configure'
