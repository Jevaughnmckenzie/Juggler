class TaskController < ApplicationController
	get '/projects/:project_id/tasks/new' do
  	if logged_in?
  		# binding.pry
  		
      erb :'tasks/new'
    else
    	redirect "/"
    end
  end

  post '/projects/:project_id/tasks' do
  	user = 

  	user.tasks.build(name: params[:name], active_status: active_status)

  	user.tasks.last.save

  	redirect '/projects/:project_id'
  end

  # get '/projects/:project_id/tasks/:id' do
  # 	if logged_in?
  		
  # 		@project = Project.find(params[:id])

  #     erb :'tasks/show'
  #   else
  #   	redirect '/'
  #   end
  # end

  get '/projects/:project_id/tasks/:id/edit' do
  	if logged_in?
  		@project = Project.find(params[:id])
      erb :'tasks/edit'
    else
    	redirect '/'
    end
  end

  patch '/projects/:project_id/tasks/:id' do
  	project = Project.find(params[:id])

  	project.name = params[:name]

  	if project.save
  		redirect "/tasks/#{project.id}"
  	else
  		# Set up error message
  		erb :'tasks/edit'
  	end
  end

  delete '/projects/:project_id/tasks/:id/delete' do
  	project = Project.find(params[:id])
  	project.delete

  	redirect '/projects/:project_id'
  end

end