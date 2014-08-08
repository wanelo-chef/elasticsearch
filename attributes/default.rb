default['elasticsearch']['master'] = false
default['elasticsearch']['search'] = 'roles:elasticsearch-master'
default['elasticsearch']['cluster'] = 'elasticsearch'

default['elasticsearch']['minimum_master_nodes'] = '2'

default['elasticsearch']['max_dynamic_heap_size'] = 30000
default['elasticsearch']['dynamic_heap_ratio'] = 0.5
default['elasticsearch']['min_heap'] = '1g'
default['elasticsearch']['max_heap'] = '1g'

default['elasticsearch']['verbose_gc'] = false
default['elasticsearch']['plugins'] = {
  'HQ' => 'royrusso/elasticsearch-HQ'
}

default['elasticsearch']['newrelic']['api_key'] = ''
default['elasticsearch']['newrelic']['app_name'] = 'ElasticSearch'
default['elasticsearch']['newrelic']['apdex_t'] = '0.5'
default['elasticsearch']['newrelic']['environment'] = 'demo'
default['elasticsearch']['newrelic']['jar_url'] = ''
