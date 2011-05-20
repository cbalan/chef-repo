#
# Cookbook Name:: drupal
# Recipe:: config
#

define :drupal_config, :config => {} do
  include_recipe "drupal::drush"

  home = params[:config][:home]
  cron = params[:config][:cron]
  success = (params[:config].has_key? :success) ? params[:config][:success] : {}
  sites = params[:config][:sites]
  sites.each do |name, settings|
    directory "#{home}/sites/#{name}" do
      action :create
      mode 0755
    end
    
    directory "#{home}/sites/#{name}/files" do
      action :create
      mode 0755
      owner "www-data"
      group "www-data"
    end
    
    includes = (settings.has_key? :includes) ? settings.delete(:includes) : []
    placeholders = (node.has_key? :placeholders) ? node[:placeholders] : {}
    
    template "#{home}/sites/#{name}/settings.php" do
      source "settings.php.erb"
      mode 0755
      variables(
        :default_settings => "#{home}/sites/default/default.settings.php",
        :settings => settings,
        :includes => includes,
        :placeholders => placeholders
      )
    end
    
    # @todo unhardcode cron interval setup
    if cron == "1" 
      cron "drupal #{home} #{name}" do
        minute "*/5"
        command "drush cron --root=#{home} --uri=#{name} | logger -t#{params[:name]}"
      end
    end
  end
  
  # @todo test success case
  success.each do |success_group, success_group_actions|
    success_group_actions.each do |success_action|
      execute success_action
    end
  end
end