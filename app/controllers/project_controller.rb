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

  get '/projects/:id' do
  	if logged_in?
  		
  		@project = Project.find(params[:id])

      erb :'projects/show'
    else
    	redirect '/'
    end
  end

  get '/projects/:id/edit' do
  	if logged_in?
  		@project = Project.find(params[:id])
      erb :'projects/edit'
    else
    	redirect '/'
    end
  end

  patch '/projects/:id/edit' do
  	project = Project.find(params[:id])

  	project.name = params[:name]
  	params[:active] == "on" ? project.active == true : project.active == false

  	if project.save
  		redirect "/projects/#{project.id}"
  	else
  		# Set up error message
  		erb :'projects/edit'
  	end
  end
  
end