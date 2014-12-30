# Encoding: utf-8

name              'puppet'
maintainer        'Fletcher Nichol'
maintainer_email  'fnichol@nichol.ca'
license           'Apache 2.0'
description       'Installs and manages a Puppet Master service. No, really.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.2.1'

supports 'ubuntu'

depends 'apt'
depends 'yum'

recipe 'puppet::default',      'Currently does nothing.'
recipe 'puppet::aws',          'Fixes up the hostname on EC2 instances.'
recipe 'puppet::client',       'Configures a Puppet Client.'
recipe 'puppet::master',       'Configures a Puppet Master.'
