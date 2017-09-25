class TaskController < ApplicationController
	get '/tasks/new' do
  	if logged_in?
  		
      erb :'tasks/new'
    else
    	redirect "/"
    end
  end

  post '/tasks' do
  	user = 

  	user.tasks.build(name: params[:name], active_status: active_status)

  	user.tasks.last.save

  	redirect '/tasks'
  end

  get '/tasks/:id' do
  	if logged_in?
  		
  		@project = Project.find(params[:id])

      erb :'tasks/show'
    else
    	redirect '/'
    end
  end

  get '/tasks/:id/edit' do
  	if logged_in?
  		@project = Project.find(params[:id])
      erb :'tasks/edit'
    else
    	redirect '/'
    end
  end

  patch '/tasks/:id' do
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
  		redirect "/tasks/#{project.id}"
  	else
  		# Set up error message
  		erb :'tasks/edit'
  	end
  end

  delete '/tasks/:id/delete' do
  	project = Project.find(params[:id])
  	project.delete

  	redirect '/tasks'
  end

end