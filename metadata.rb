name             'elasticsearch'
maintainer       'Wanelo'
maintainer_email 'play@wanelo.com'
license          'MIT'
description      'Installs/Configures elasticsearch on Joyent SmartOS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.1'

depends 'smf', '>= 2.0.4'
