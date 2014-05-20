# elasticsearch cookbook

Installs and configures the Joyent Elasticsearch distribution on a SmartOS image.

# Usage

Add `recipe[elasticsearch]` to your run_list on each `elasticsearch` node. The configure
recipe will search for all nodes matching `elasticsearch-master` and drop those hosts into the
the configuration.

# Recipes

* `elasticsearch::install`
* `elasticsearch::configure`
