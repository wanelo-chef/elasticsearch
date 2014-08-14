default['elasticsearch']['version'] = '1.3.1'
default['elasticsearch']['mirror'] = 'https://download.elasticsearch.org/elasticsearch/elasticsearch'
default['elasticsearch']['checksum'] = 'add61343400d099f005f3b190b8b34aa35af0c5014c954d04e6c63485a400239'

default['elasticsearch']['restart_on_smf_change'] = true

default['elasticsearch']['master'] = false
default['elasticsearch']['search'] = 'roles:elasticsearch-master'
default['elasticsearch']['cluster'] = 'elasticsearch'

default['elasticsearch']['minimum_master_nodes'] = '2'

default['elasticsearch']['path'] = node['paths']['bin_path']
default['elasticsearch']['java_home'] = '/opt/local/java/openjdk7'
default['elasticsearch']['max_dynamic_heap_size'] = 30000
default['elasticsearch']['dynamic_heap_ratio'] = 0.5
default['elasticsearch']['min_heap'] = '1g'
default['elasticsearch']['max_heap'] = '1g'
default['elasticsearch']['store_type'] = 'niofs'

default['elasticsearch']['verbose_gc'] = false
default['elasticsearch']['garbage_collector'] = nil

default['elasticsearch']['plugins'] = {
  'HQ' => 'royrusso/elasticsearch-HQ'
}

default['elasticsearch']['newrelic']['api_key'] = ''
default['elasticsearch']['newrelic']['app_name'] = 'ElasticSearch'
default['elasticsearch']['newrelic']['apdex_t'] = '0.5'
default['elasticsearch']['newrelic']['environment'] = 'demo'
default['elasticsearch']['newrelic']['jar_url'] = ''
