default['elasticsearch']['version'] = '1.3.1'
default['elasticsearch']['mirror'] = 'https://download.elasticsearch.org/elasticsearch/elasticsearch'
default['elasticsearch']['checksum'] = 'add61343400d099f005f3b190b8b34aa35af0c5014c954d04e6c63485a400239'

default['elasticsearch']['restart_on_smf_change'] = true

default['elasticsearch']['master'] = false
default['elasticsearch']['data'] = true
default['elasticsearch']['search'] = 'roles:elasticsearch-master'
default['elasticsearch']['cluster'] = 'elasticsearch'

default['elasticsearch']['minimum_master_nodes'] = '2'

default['elasticsearch']['path'] = node['paths']['bin_path']
default['elasticsearch']['java_bin'] = nil
default['elasticsearch']['java_env'] = nil
default['elasticsearch']['java_home'] = '/opt/local/java/openjdk7'
default['elasticsearch']['max_dynamic_heap_size'] = 30000
default['elasticsearch']['dynamic_heap_ratio'] = 0.5
default['elasticsearch']['min_heap'] = '1g'
default['elasticsearch']['max_heap'] = '1g'
default['elasticsearch']['store_type'] = 'niofs'
default['elasticsearch']['max_perm_size'] = '128m'
default['elasticsearch']['additional_config'] = {}

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

default['elasticsearch']['syslog']['enabled'] = false
default['elasticsearch']['syslog']['server'] = '127.0.0.1'
default['elasticsearch']['syslog']['port'] = '514'
default['elasticsearch']['syslog']['facility'] = 'local5'
default['elasticsearch']['syslog']['log_format'] = '[%d{ISO8601}][%-5p][%-25c] %m%n'

default['elasticsearch']['log_rotation']['keep'] = 7
default['elasticsearch']['log_rotation']['gc_template'] = '/var/log/elasticsearch/$basename.%Y%m%d'
default['elasticsearch']['log_rotation']['rotation_dir'] = nil
