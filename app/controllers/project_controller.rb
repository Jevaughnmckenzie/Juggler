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

  post '/projects' do
  	user = current_user
    
  	params[:active] == "on" ? active_status = true : active_status = false

  	user.projects.build(name: params[:name], active?: active_status)

  	user.projects.last.save

  	redirect '/projects'
  end
  
end