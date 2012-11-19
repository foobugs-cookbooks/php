#
# Author:: René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Recipe:: fpm
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

if node["platform_family"] == "debian"
  package "php5-fpm" do
    action :install
  end

  template "#{node['php']['conf_dir']}/fpm/php.ini" do
    source "fpm/php54.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    only_if {File.exists?("#{node['php']['conf_dir']}/fpm/php.ini")}
    notifies :restart, resources(:service => "php5-fpm")
  end

  # service "php5-fpm" do
  #   action :restart
  # end
end
