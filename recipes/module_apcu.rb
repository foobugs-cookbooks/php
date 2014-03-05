#
# Author:: Maik Penz (<maik.penz@foobugs.com>)
# Cookbook Name:: php
# Recipe:: module_apcu
#
# Copyright 2014, Penz Programmierung
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when "rhel", "fedora"
  %w{ httpd-devel pcre pcre-devel }.each do |pkg|
    package pkg do
      action :install
    end
  end
  php_pear "apcu" do
    action :install
    directives(:shm_size => "32M", :enable_cli => 1)
  end
when "debian"
  package "php-apcu" do
    action :install
  end
end
