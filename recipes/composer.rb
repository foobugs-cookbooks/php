#
# Author:: René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Recipe:: composer
#
# Copyright 2012, foobugs Oelke & Eichner GbR
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

# Download composer installer
remote_file "#{Chef::Config[:file_cache_path]}/composer-installer" do
  source "https://getcomposer.org/installer"
  mode "0644"
  action :create 
end

# Install composer.phar
bash "Install composer.phar" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    php composer-installer --install-dir=#{node["php"]["composer"]["install_path"]}
    rm composer-installer
  EOH
end

# Install composer executable
template "#{node["php"]["composer"]["exec_path"]}/composer" do
  source "composer.erb"
  owner "root"
  group "root"
  mode "0755"
end
