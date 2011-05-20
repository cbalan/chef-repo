#
# Cookbook Name:: magento
# Recipe:: config
#

define :magento_config, :config => {} do
  home = params[:config][:home]
  local = params[:config][:local]
  cron = params[:config][:cron]
  success = (params[:config].has_key? :success) ? params[:config][:success] : {}
  placeholders = (node.has_key? :placeholders) ? node[:placeholders] : {}

  %w{var var/cache var/locks var/report var/log media media/customer media/downloadable media/import media/flv staging}.each do |directory_name|
    directory "#{home}/#{directory_name}" do
      action :create
      mode 0755
      owner "www-data"
      group "www-data"
      recursive true
    end
  end
  
  template "#{home}/app/etc/local.xml" do
    source "local.xml.erb"
    mode 0755
    variables(
      :local => local,
      :placeholders => placeholders
    )
  end
  
  file "#{home}/cron.sh" do
    mode 0755
  end
  
  # @todo unhardcode cron interval setup
  if cron == "1"
    cron "magento #{home}" do
      command "#{home}/cron.sh | logger -t#{params[:name]}"
    end
  end
  
  success.each do |success_group, success_group_actions|
    success_group_actions.each do |success_action|
      execute success_action
    end
  end
end