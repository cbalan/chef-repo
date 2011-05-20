#
# Cookbook Name:: drupal
# Recipe:: drush
#

bash "drush_install" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    curl #{node[:drush][:download_url]} | tar -xz -C /opt
  EOH
  not_if do File.exists?("/opt/drush/drush") end
end

link "/usr/bin/drush" do
  to "/opt/drush/drush"
end