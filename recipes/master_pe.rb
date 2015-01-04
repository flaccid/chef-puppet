#
# Cookbook Name:: puppet
# Recipe:: master_pe
#
# Copyright 2014-2015, Chris Fordham
# Copyright 2014-2015, Fletcher Nichol
#
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

include_recipe 'build-essential'
include_recipe 'apt' if node['platform_family'] == 'debian'

# import the Puppet Labs public key
execute 'import_puppetlabs_gpg' do
  command 'gpg --keyserver=pgp.mit.edu --recv-key 4BD6EC30'
  not_if { ::Mixlib::ShellOut.new('gpg --list-keys').stdout.include?('4BD6EC30') }
end

# example reference url:
# https://s3.amazonaws.com/pe-builds/released/3.7.0/puppet-enterprise-3.7.1-ubuntu-14.04-amd64.tar.gz
ark 'puppet-pe' do
  url "https://s3.amazonaws.com/pe-builds/released/#{node['puppet']['pe']['puppet_version']}/" \
    "puppet-enterprise-#{node['puppet']['pe']['puppet_version']}-" \
    "#{node['puppet']['pe']['platform']}-" \
    "#{node['puppet']['pe']['platform_version']}-#{node['puppet']['pe']['arch']}.tar.gz"
end

template "#{Chef::Config[:file_cache_path]}/puppet_install_answers.txt" do
  source  node['puppet']['pe']['answers_template']
  mode    '400'
  owner   'root'
  group   'root'
  variables(
    puppet_enterpriseconsole_auth_password: node['puppet']['pe']['puppet_enterpriseconsole_auth_password'],
    puppet_enterpriseconsole_auth_user_email: node['puppet']['pe']['puppet_enterpriseconsole_auth_user_email'],
    puppet_enterpriseconsole_smtp_host: node['puppet']['pe']['puppet_enterpriseconsole_smtp_host'],
    puppetdb_database_name: node['puppet']['pe']['puppetdb_database_name'],
    puppetdb_database_password: node['puppet']['pe']['puppetdb_database_password'],
    puppetdb_database_user: node['puppet']['pe']['puppetdb_database_user'],
    puppetmaster_server: node['puppet']['master_conf']['main']['server'],
    puppetmaster_certname: node['puppet']['master_conf']['main']['certname']
  )
end

execute 'install_pe-puppet' do
  cwd '/usr/local/puppet-pe'
  command "./puppet-enterprise-installer -a #{Chef::Config[:file_cache_path]}/puppet_install_answers.txt"
end

include_recipe 'puppet::master_pe_services'
