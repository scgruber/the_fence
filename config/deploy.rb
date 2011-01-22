require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, "ruby-1.8.7-p302"

# Server Settings
# Comment this out if you're using Multistage support.
set :user, "deploy"
set :server_name, "www.takethefence.com"
role :app, server_name
role :web, server_name
role :db,  server_name, :primary => true

# Application Settings
set :application, "fence"
set :deploy_to, "/var/apps/#{application}"

# Repo Settings
set :repository,  "#{user}@#{server_name}:#{application}.git"
set :scm, "git"
set :branch, "master"
set :checkout, 'export'
set :git_enable_submodules, 1

# General Settings
default_run_options[:pty] = true
set :keep_releases, 5
set :use_sudo, false

# Hooks
after "deploy", "deploy:cleanup"
after "deploy:update_code", "deploy:web:update_maintenance_page"
after "deploy:update_code", "deploy:secondary_symlink"

namespace :deploy do
  task :secondary_symlink, :except => { :no_release => true } do
    run "rm -f #{release_path}/config/database.yml"
    run "ln -s #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    
    run "rm -f #{release_path}/config/mongoid.yml"
    run "ln -s #{deploy_to}/shared/config/mongoid.yml #{release_path}/config/mongoid.yml"
    
    run "rm -rf #{release_path}/etc/"
    run "ln -s #{deploy_to}/shared/etc #{release_path}/etc"
  end

  task :restart, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :start, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

# Disable the built in disable command and setup some intelligence so we can have images.
disable_path = "#{shared_path}/system/maintenance/"
namespace :deploy do
  namespace :web do
    desc "Disables the website by putting the maintenance files live."
    task :disable, :except => { :no_release => true } do
      on_rollback { run "mv #{disable_path}index.html #{disable_path}index.disabled.html" }
      run "mv #{disable_path}index.disabled.html #{disable_path}index.html"
    end

    desc "Enables the website by disabling the maintenance files."
    task :enable, :except => { :no_release => true } do
        run "mv #{disable_path}index.html #{disable_path}index.disabled.html"
    end

    desc "Copies your maintenance from public/maintenance to shared/system/maintenance."
    task :update_maintenance_page, :except => { :no_release => true } do
      run "rm -rf #{shared_path}/system/maintenance/; true"
      run "mkdir -p #{release_path}/public/maintenance"
      run "touch #{release_path}/public/maintenance/index.html.disabled"
      run "cp -r #{release_path}/public/maintenance #{shared_path}/system/"
    end
  end
end
