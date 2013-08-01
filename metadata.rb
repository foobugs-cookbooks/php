maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and maintains php and php modules"
version           "1.1.0"

depends "apt"
depends "build-essential"
depends "xml"
depends "mysql"

%w{ debian ubuntu centos redhat fedora scientific amazon }.each do |os|
  supports os
end

recipe "php", "Installs php"
recipe "php::package", "Installs php using packages."
recipe "php::source", "Installs php from source."
recipe "php::module_apc", "Install the php5-apc package"
recipe "php::module_curl", "Install the php5-curl package"
recipe "php::module_fileinfo", "Install the php5-fileinfo package"
recipe "php::module_fpdf", "Install the php-fpdf package"
recipe "php::module_gd", "Install the php5-gd package"
recipe "php::module_ldap", "Install the php5-ldap package"
recipe "php::module_memcache", "Install the php5-memcache package"
recipe "php::module_mysql", "Install the php5-mysql package"
recipe "php::module_pgsql", "Install the php5-pgsql packag"
recipe "php::module_sqlite3", "Install the php5-sqlite3 package"

recipe "php::package_php54", "Installs PHP 5.4 using packages."
recipe "php::package_php55", "Installs PHP 5.5 using packages."
recipe "php::phbuild", "Installs phpbuild for compiling PHP"
recipe "php::source_php54", "Installs PHP 5.4 using sources."
recipe "php::source_php55", "Installs PHP 5.5 using sources."
recipe "php::fpm", "Installs FastCGI Process Manager for PHP 5.4"
recipe "php::fpm55", "Installs FastCGI Process Manager for PHP 5.5"
recipe "php::composer", "Installs Composer"
recipe "php::phing", "Installs Phing"
recipe "php::phpunit", "Installs PHPUnit"
