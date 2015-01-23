name             'elasticsearch'
maintainer       'Wanelo'
maintainer_email 'play@wanelo.com'
license          'MIT'
description      'Installs/Configures elasticsearch on Joyent SmartOS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.12.1'

depends 'java'
depends 'logadm'
depends 'paths'
depends 'resource-control'
depends 'smf', '>= 2.2.0'
