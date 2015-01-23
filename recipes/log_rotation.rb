include_recipe 'logadm'

helper = Elasticsearch::Helper::LogRotation.new(node)

logadm 'elasticsearch-gc' do
  path '/var/log/elasticsearch/gc.log'
  template node['elasticsearch']['log_rotation']['gc_template']
  count 5
  period '1d'
  gzip 0
  copy true
end

cron 'rotate elasticsearch logs' do
  command helper.cron
  minute 30
  hour 2
  action helper.rotate_logs? ? :create : :delete
end
