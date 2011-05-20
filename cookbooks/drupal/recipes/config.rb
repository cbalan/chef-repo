#
# Cookbook Name:: drupal
# Recipe:: config
#

node[:drupal].each do |name, config|
  Chef::Log.debug("Configuring drupal #{name} using JSON: #{JSON.pretty_generate(config)}")
  drupal_config name do
    config config
  end
end
