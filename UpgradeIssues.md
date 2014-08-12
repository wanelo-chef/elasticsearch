# Upgrading this cookbook

## 0.9.0

Previous versions of the cookbook installed elasticsearch from pkgsrc. This version installs from a tar file,
symlinking a version-specific lib directory to `/opt/local/lib/elasticsearch`. If the previous version of the cookbook
has run, this directory will already exist.

In order to upgrade to 0.9.0, please manually delete the existing directory.
