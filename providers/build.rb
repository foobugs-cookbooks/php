#
# Author:: René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Provider:: build
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

action :create do
  Chef::Log.info("Installing PHP #{@new_resource.version} with php-build")
  new_resource = @new_resource
  phpbuild_path = "#{Chef::Config[:file_cache_path]}/#{node["php"]["phpbuild"]["path"]}"
  version = new_resource.version
  prefix = "#{new_resource.prefix}"

  bash "install PHP #{version} with php-build" do
    user new_resource.owner
    group new_resource.group
    environment Hash["LDFLAGS" => "-lstdc++"]
    cwd "#{phpbuild_path}/bin"
    ini_suffix = version < '5.3' ? 'dist' : 'development'
    code <<-EOF
      PHP_VERSION=#{version} ./php-build -i #{ini_suffix} #{version} #{prefix}
    EOF
  end

  new_resource.updated_by_last_action(true)
end
