name             'td-agent-config'
maintainer       'brightgenerous'
maintainer_email 'katou.akihiro@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures td-agent-config'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
recipe           'td-agent-config', 'td-agent config'

supports 'centos'
supports 'fedora'
supports 'redhat'

depends 'td-agent'
