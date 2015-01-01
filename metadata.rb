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
depends 'ark'
depends 'build-essential'

recipe 'puppet::default',      'Currently does nothing.'
recipe 'puppet::aws',          'Fixes up the hostname on EC2 instances.'
recipe 'puppet::client',       'Configures a Puppet Client.'
recipe 'puppet::master',       'Configures a Puppet Master.'
recipe 'puppet::master_pe',    'Configures a PE Puppet Master.'
recipe 'puppet::agent_td',     'Executes puppet agent -td.'

attribute 'puppet/client_conf/main/server',
          display_name: 'Puppet Master Hostname',
          description: 'The hostname of the Puppet Master.',
          default: 'localhost',
          recipes: ['puppet::default', 'puppet::master', 'puppet::client', 'puppet::client_pe']

attribute 'puppet/autosign/whitelist',
          display_name: 'Puppet Master Autosign Whitelist',
          description: 'A list of client hostnames to whitelist, allowing autosigning of their certificates.',
          default: ['*.com', '*.net', '*.org', '*.local', '*.ec2.internal', '*.compute-1.amazonaws.com', 'puppet'],
          type: 'array',
          recipes: ['puppet::default', 'puppet::master']

attribute 'puppet/master_conf/main/certname',
          display_name: 'Puppet Master Certificate Name',
          description: 'The certname directive (CN) for the Puppet Master (default is node[\'fqdn\']).',
          recipes:  ['puppet::default', 'puppet::master']

attribute 'puppet/pe/puppet_version',
          display_name: 'PE Puppet Version',
          description: 'The version of PE Puppet to use (default 3.7.0)',
          default: '3.7.0',
          recipes: ['puppet::master_pe']

attribute 'puppet/pe/puppet_enterpriseconsole_auth_password',
          display_name: 'PE Puppet Console Password',
          description: 'The PE console password.',
          default: 'Super53cure',
          recipes: ['puppet::master_pe']

attribute 'puppet/pe/puppet_enterpriseconsole_auth_user_email',
          display_name: 'PE Puppet Console User Email',
          description: 'The PE console user email',
          default: 'admin@example.com',
          recipes: ['puppet::master_pe']

attribute 'puppet/pe/puppet_enterpriseconsole_smtp_host',
          display_name: 'PE Puppet Console SMTP Host',
          description: 'The PE console\'s SMTP host',
          default: 'localhost',
          recipes: ['puppet::master_pe']
