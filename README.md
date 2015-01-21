# ElasticSearch cookbook

[![Build status](https://secure.travis-ci.org/wanelo-chef/elasticsearch.png)](http://travis-ci.org/wanelo-chef/elasticsearch)

Installs and configures the Joyent Elasticsearch distribution on a SmartOS image.

## Usage

Add `recipe[elasticsearch]` to your run_list on each `elasticsearch` node. The configure
recipe will search for all nodes matching `elasticsearch-master` and drop those hosts into the
the configuration.

Changes to configuration will not restart elasticsearch. Once new configurations are applied,
manual intervention will be required to restart each service on each node.

## Memory Usage

By default the recipe will set the heap memory size to half of the available RAM, or 30GB
(whichever is smaller).  To override those, please set the following:

```ruby
node.override['elasticsearch']['min_heap'] = '6g'
node.override['elasticsearch']['max_heap'] = '6g'
```

## Malloc

By default, ElasticSearch will utilize the `malloc` linked by Java. On Solaris-like OSs, this
can be overridden with `LD_PRELOAD`. To do this, ensure that the Java executable used matches
the malloc used (32bit or 64bit). This can be done by overriding the
`node['elasticsearch']['java_bin']` attribute.

Override `malloc` using the `JAVA_ENV` environment variable, set by
`node['elasticsearch']['java_env']`.

```ruby
node.override['elasticsearch']['java_bin'] = '/opt/local/java/jdk1.7.0_67/bin/amd64/java'
node.override['elasticsearch']['java_env'] = 'LD_PRELOAD=/usr/lib/64/libumem.so'
# or
node.override['elasticsearch']['java_env'] = 'LD_PRELOAD=/usr/lib/64/libmtmalloc.so'
```

Note that when using `java -d64`, the initial exec may start a 32bit java, which then execs
the 64bit binary. This may conflict with the version of `malloc` loaded.

## Recipes

* `elasticsearch::install`
* `elasticsearch::configure`
* `elasticsearch::smf`


## Known issues when upgrading this cookbook

See (Upgrading this cookbook)[https://github.com/wanelo-chef/elasticsearch/blob/master/UpgradeIssues.md] for any specific
notes on upgrading.
