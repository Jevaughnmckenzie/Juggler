require './config/environment'
class ProjectController < ApplicationController
  
  get '/projects' do
  	if logged_in?
  	  user = current_user

      @active_projects = user.projects.select { |project| project.active? }
      @inactive_projects = user.projects.reject { |project| project.active? }

      @projects = user.projects
      erb :'projects/index'
    else
  	  redirect '/'
    end
  end

  get '/projects/new' do
  	if logged_in?
  		
      erb :'projects/new'
    else
    	redirect '/'
    end
  end


  
end