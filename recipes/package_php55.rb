#
# Author::  René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Recipe:: package_php55
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

if node["platform_family"] == "debian"
  case node["lsb"]["codename"]
  when "precise", "quantal", "raring"
    apt_repository "ondrej-systemd" do
      uri "http://ppa.launchpad.net/ondrej/systemd/ubuntu"
      distribution node["lsb"]["codename"]
      components ["main"]
      deb_src true
      keyserver "keyserver.ubuntu.com"
      key "E5267A6C"
    end
    apt_repository "ondrej-php55" do
      uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
      distribution node["lsb"]["codename"]
      components ["main"]
      deb_src true
      keyserver "keyserver.ubuntu.com"
      key "E5267A6C"
    end
  when "wheezy"
    apt_repository "dotdeb-php55" do
      uri "http://packages.dotdeb.org"
      distribution node["lsb"]["codename"]
      components ["wheezy-php55"]
      deb_src true
      key "http://www.dotdeb.org/dotdeb.gpg"
    end
  end
end

pkgs = value_for_platform(
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-cgi php5 php5-dev php5-cli php-pear }
  }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

if node["platform_family"] == "debian"
  template "#{node['php']['conf_dir']}/cgi/php.ini" do
    source "cgi/php55.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    only_if {File.exists?("#{node['php']['conf_dir']}/cgi/php.ini")}
  end

  template "#{node['php']['conf_dir']}/cli/php.ini" do
    source "cli/php55.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    only_if {File.exists?("#{node['php']['conf_dir']}/cli/php.ini")}
  end
end
