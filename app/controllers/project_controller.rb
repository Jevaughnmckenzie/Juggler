require './config/environment'
class ProjectController < ApplicationController
  
  get '/projects' do
  	if logged_in?
  	  user = current_user

      @active_projects = user.projects.select { |project| project.active_status }
      @inactive_projects = user.projects.reject { |project| project.active_status }

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

  	user.projects.build(name: params[:name], active_status: active_status)

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

  patch '/projects/:id' do
  	project = Project.find(params[:id])

  	project.name = params[:name]
  	binding.pry
  	if params[:status] == "active"
  		project.active_status = true 
  	elsif params[:status] == "inactive"
  		project.active_status = false
  	end

  	# if params[:status] == "on"
  	# 	project.active_status = true
  	# else
  	# 	project.active_status = false
  	# end

  	if project.save
  		redirect "/projects/#{project.id}"
  	else
  		# Set up error message
  		erb :'projects/edit'
  	end
  end

  delete '/projects/:id/delete' do
  	project = Project.find(params[:id])
  	project.delete

  	redirect '/projects'
  end


  
end