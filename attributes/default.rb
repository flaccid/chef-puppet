#
# Cookbook Name:: puppet
# Attributes:: default
#
# Copyright 2012, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['puppet']['edition'] = 'oss'

# IP for the server is only used when explicitly set by the user
# for environments which don't have adequate resolution or
# have a bad resolution pointing back to localhost
default['puppet']['server_ip'] = nil

# By default the following will be autosigned;
# Ensure your server is only accessible by your nodes (not public).
default['puppet']['autosign']['whitelist'] = ['*.com',
                                              '*.net',
                                              '*.org',
                                              '*.local',
                                              '*.ec2.internal',
                                              '*.compute-1.amazonaws.com',
                                              'puppet']

##############################################################################
# Server specific configurations
# Everything in the master_conf hash is included in puppet.conf when you use
# the master.pp recipe.
##############################################################################
default['puppet']['master_conf']['main']['logdir']      = '/var/log/puppet'
default['puppet']['master_conf']['main']['vardir']      = '/var/lib/puppet'
default['puppet']['master_conf']['main']['ssldir']      = '/var/lib/puppet/ssl'
default['puppet']['master_conf']['main']['rundir']      = '/var/run/puppet'
default['puppet']['master_conf']['main']['autosign']    = '$confdir/autosign.conf'
default['puppet']['master_conf']['main']['factpath']    = '$vardir/lib/facter'
default['puppet']['master_conf']['main']['templatedir'] = '$confdir/templates'
default['puppet']['master_conf']['main']['certname']    = node['fqdn']
default['puppet']['master_conf']['main']['server']      = node['puppet']['master_conf']['main']['certname']
default['puppet']['master_conf']['main']['dns_alt_names'] = 'puppet'
default['puppet']['master_conf']['master']['ssl_client_header']        = 'SSL_CLIENT_S_DN'
default['puppet']['master_conf']['master']['ssl_client_verify_header'] = 'SSL_CLIENT_VERIFY'

# These gems and packages are for the master and passenger recipes
default['puppet']['passenger']['gems'] = %w(rack passenger)
case node['platform_family']
when 'rhel'
  default['puppet']['package_name'] = 'puppet-server'
  default['puppet']['passenger']['packages'] = %w(httpd httpd-devel mod_ssl ruby-devel rubygems gcc gcc-c++ curl-devel openssl-devel zlib-devel)
when 'debian'
  default['puppet']['package_name'] = 'puppetmaster'
  default['puppet']['passenger']['packages'] = %w(apache2 ruby1.8-dev rubygems)
end

# Module list to install from Puppet Forge
default['puppet']['modules']['install'] = %w(stdlib concat mysql java apache)

# Modules you want to use in the load test recipe
default['puppet']['modules']['loadtest'] = %w(stdlib mysql::server java apache)

##############################################################################
# Client specific configurations
# Everything in the master_conf hash is included in puppet.conf when you use
# the client.pp recipe.
##############################################################################
default['puppet']['client_conf']['main']['logdir']      = '/var/log/puppet'
default['puppet']['client_conf']['main']['vardir']      = '/var/lib/puppet'
default['puppet']['client_conf']['main']['ssldir']      = '/var/lib/puppet/ssl'
default['puppet']['client_conf']['main']['rundir']      = '/var/run/puppet'
default['puppet']['client_conf']['main']['factpath']    = '$vardir/lib/facter'
default['puppet']['client_conf']['main']['templatedir'] = '$confdir/templates'
default['puppet']['client_conf']['main']['server']      = 'localhost'

##############################################################################
# Amazon AWS EC2 settings
# Auto-detect if we are in ec2, append local hostname to dns_alt_names
##############################################################################
unless node['cloud'].nil?
  if node['cloud']['provider'] == 'ec2'
    default['puppet']['master_conf']['main']['dns_alt_names'] = "puppet, #{node['ec2']['local_hostname']}"
  end
end

# pe-puppet has different filesystem hierachy :(
case node['puppet']['edition']
when 'oss'
  default['puppet']['confdir'] = '/etc/puppet'
when 'pe'
  default['puppet']['confdir'] = '/etc/puppetlabs/puppet'
end

# pe-puppet
default['puppet']['pe']['answers_template'] = 'monolithic-basic.txt.erb'
default['puppet']['pe']['arch'] = 'x86_64'

case node['platform_family']
when 'debian'
  default['puppet']['pe']['platform'] = 'ubuntu'
  default['puppet']['pe']['platform_version'] = '14.04'
  default['puppet']['pe']['arch'] = 'amd64'
when 'rhel'
  default['puppet']['pe']['platform'] = 'el'
  default['puppet']['pe']['platform_version'] = '6'
end

default['puppet']['pe']['puppet_version'] = '3.7.0'
default['puppet']['pe']['puppet_enterpriseconsole_auth_password'] = 'Super53cure'
default['puppet']['pe']['puppet_enterpriseconsole_auth_user_email'] = 'admin@example.com'
default['puppet']['pe']['puppet_enterpriseconsole_smtp_host'] = 'localhost'
default['puppet']['pe']['puppetdb_database_name'] = 'pe-puppetdb'
default['puppet']['pe']['puppetdb_database_password'] = 'Uber53cure'
default['puppet']['pe']['puppetdb_database_user'] = 'pe-puppetdb'
