#
# Cookbook Name:: puppet
# Recipe:: hostsfile
#
# Copyright 2014, Sean Carolan
# Copyright 2015, Chris Fordham
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

# Add an entry to /etc/hosts for the puppet master server IP
# if explicitly set and not equal to localhost

hostsfile_entry node['puppet']['server_ip'] do
  hostname node['puppet']['client_conf']['main']['server']
  not_if   { node['puppet']['server_ip'] == '127.0.0.1' }
  action   :create
end
