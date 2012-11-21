#
# Author:: René Oelke (<rene.oelke@foobugs.com>)
# Cookbook Name:: php
# Attribute:: phpbuild
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

required_packages = %w{}

case node["platform_family"]
when "debian"
  required_packages += %w{
    libldap2-dev
    libxslt1-dev
    libssl0.9.8
    libssl-dev
    zlib1g-dev
    libbz2-dev
    libc-client2007e-dev
    libcurl4-openssl-dev
    libfreetype6-dev
    libgmp3-dev
    libjpeg8-dev
    libmcrypt-dev
    libpng12-dev
    libt1-dev
    libmhash-dev
    libexpat1-dev
    libicu-dev
    libtidy-dev
    re2c
    lemon
  }
end

default["php"]["phpbuild"]["required_packages"] = required_packages
default["php"]["phpbuild"]["arch"] = (kernel['machine'] =~ /x86_64/ ? "x86_64" : "i386")
default["php"]["phpbuild"]["path"] = "php-build"

default["php"]["phpbuild"]["git_repository"] = "git://github.com/CHH/php-build.git"
default["php"]["phpbuild"]["git_revision"] = "807ef1e1c79d2e010da58e50861ebd55b9bd1adb"
