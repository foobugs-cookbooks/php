actions :create

attribute :prefix, :kind_of => String, :name_attribute => true
attribute :version, :default => "5.4.8"
attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]
