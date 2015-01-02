#
# Cookbook Name:: puppet
# Recipe:: master_pe_services
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

# this recipe (currently) should not be run without the
# master_pe recipe in the run_list or pe-puppet already installed

service 'pe-activemq'
service 'pe-console-services'
service 'pe-httpd'
service 'pe-mcollective'
service 'pe-memcached'
service 'pe-postgresql'
service 'pe-puppet'
service 'pe-puppet-dashboard-workers'
service 'pe-puppetdb'
service 'pe-puppetserver'
