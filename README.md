# ElasticSearch cookbook

[![Build status](https://secure.travis-ci.org/wanelo-chef/elasticsearch.png)](http://travis-ci.org/wanelo-chef/elasticsearch)

Installs and configures the Joyent Elasticsearch distribution on a SmartOS image.

# Usage

Add `recipe[elasticsearch]` to your run_list on each `elasticsearch` node. The configure
recipe will search for all nodes matching `elasticsearch-master` and drop those hosts into the
the configuration.

# Memory Usage

By default the recipe will set the heap memory size to half of the available RAM, or 30GB
(whichever is smaller).  To override those, please set the following:

```ruby
node.override['elasticsearch']['min_heap'] = '6g'
node.override['elasticsearch']['max_heap'] = '6g'
```

# Recipes

* `elasticsearch::install`
* `elasticsearch::configure`
* `elasticsearch::smf`
