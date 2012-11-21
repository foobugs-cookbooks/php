#
# Author:: René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Recipe:: phpbuild
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

include_recipe "apt"
include_recipe "git"

include_recipe "build-essential"

# include_recipe "networking_basic"
  # lsof
  # iptables
  # curl
  # wget
  # rsync

include_recipe "mysql::client"
include_recipe "postgresql::client"

include_recipe "xml"

case node["platform_family"]
when "debian"
  node["php"]["phpbuild"]["required_packages"].each do |pkg|
    package pkg do
      action :install
    end
  end

  link "/usr/lib/libpng.so" do
    to "/usr/lib/#{node["php"]["phpbuild"]["arch"]}-linux-gnu/libpng.so"
  end

  if node["platform"] == "ubuntu"
    if node["platform_version"].to_f >= 12.04
      link "/usr/lib/libmysqlclient.so" do
        to "/usr/lib/#{node["php"]["phpbuild"]["arch"]}-linux-gnu/libmysqlclient.so"
      end
    end

    if node["platform_version"].to_f >= 11.10
      package "libltdl-dev" do
        action :install
      end

      link "/usr/lib/libjpeg.so" do
        to "/usr/lib/#{node["php"]["phpbuild"]["arch"]}-linux-gnu/libjpeg.so"
      end

      link "/usr/lib/libstdc++.so.6" do
        to "/usr/lib/#{node["php"]["phpbuild"]["arch"]}-linux-gnu/libstdc++.so.6"
      end
    end
  end
end

phpbuild_path = "#{Chef::Config[:file_cache_path]}/#{node["php"]["phpbuild"]["path"]}"

git phpbuild_path do
  user {Chef::Config[:user]}
  group {Chef::Config[:group]}
  repository node["php"]["phpbuild"]["git_repository"]
  revision node["php"]["phpbuild"]["git_revision"]
  action :checkout
end

directory "#{phpbuild_path}/tmp" do
  user {Chef::Config[:user]}
  group {Chef::Config[:group]}
  mode "0755"
  action :create
end

template "#{phpbuild_path}/share/php-build/default_configure_options" do
  source "phpbuild/default_configure_options.erb"
  owner {Chef::Config[:user]}
  group {Chef::Config[:group]}
end

remote_directory "#{phpbuild_path}/share/php-build/definitions" do
  source "phpbuild/definitions"
  owner {Chef::Config[:user]}
  group {Chef::Config[:group]}
  files_owner {Chef::Config[:user]}
  files_group {Chef::Config[:group]}
  files_mode "0755"
end
