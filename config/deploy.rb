require 'bundler/capistrano'

set :application, "Horsemenclub"
set :domain,      "horsemenclub.com"
set :user,        "hmc"
set :repository,  "git@github.com:newmetl/Horsemenclub.git"

set :rails_env,   "production"

set :branch, "master" unless exists?(:branch)

set :deploy_to,   "/home/#{user}/#{rails_env}"
set :use_sudo,    false

ssh_options[:forward_agent] = true
set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task(:start,   :roles => :app) {}
  task(:stop,    :roles => :app) {}
  task(:restart, :roles => :app, :except => { :no_release => true }) {
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  }
end
