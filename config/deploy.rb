set :application, "oravner"
set :repository,  "git://github.com/sunchess/oravner.git"
set :domain, "92.63.102.246" 
set :scm, :git

set :user, "deploy"                 # Your HostingRails username
set :password, "UQoeJUQY"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/#{application}"          # Where on the server your app will be deployed
set :deploy_via, :export                # For this tutorial, svn checkout will be the deployment method

set :use_sudo, false  

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

default_run_options[:shell] = false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

  namespace :deploy do
    
   task :after_symlink do
    run "rm -rf #{release_path}/tmp"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/production.sqlite3 #{release_path}/db/production.sqlite3"
  end


#   task :start do ; end
#   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
