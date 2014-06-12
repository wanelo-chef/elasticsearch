default['elasticsearch']['master'] = false
default['elasticsearch']['search'] = 'roles:elasticsearch-master'
default['elasticsearch']['cluster'] = 'elasticsearch'

default['elasticsearch']['minimum_master_nodes'] = '2'

default['elasticsearch']['min_heap'] = '1g'
default['elasticsearch']['max_heap'] = '1g'

default['elasticsearch']['plugins'] = %w(royrusso/elasticsearch-HQ)
