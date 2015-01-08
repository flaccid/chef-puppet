#
# Cookbook Name:: puppet
# Recipe:: client
#
# Copyright 2014-2015, Chris Fordham
# Copyright 2014-2015, Fletcher Nichol
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

# https://docs.puppetlabs.com/pe/latest/install_agents.html

remote_file "#{Chef::Config[:file_cache_path]}/install.bash" do
  source "https://#{node['puppet']['server_ip'] || node['puppet']['client_conf']['main']['server']}:8140/packages/current/install.bash"
  owner 'root'
  group 'root'
  mode '755'
end

execute 'install_pe_puppet_client' do
  command "/bin/bash #{Chef::Config[:file_cache_path]}/install.bash | /bin/bash -s agent:environment=#{node['puppet']['agent']['environment']}"
  not_if { ::File.exist?('/opt/puppet/bin/puppet') }
end
