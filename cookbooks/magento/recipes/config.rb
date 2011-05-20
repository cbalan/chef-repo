#
# Cookbook Name:: magento
# Recipe:: config
#

# @todo handle xml-simple ruby dependency. the following lines are not working as expected with chef-0.8.16.3
# For now will have this dependency installed before chef call, so this recipe assumes that xml-simple is installed.
#package "xml-simple" do
#  provider Chef::Provider::Package::Rubygems
#end

node[:magento].each do |name, config|
  Chef::Log.debug("Configuring magento #{name} using JSON: #{JSON.pretty_generate(config)}")
  magento_config name do
    config config
  end
end