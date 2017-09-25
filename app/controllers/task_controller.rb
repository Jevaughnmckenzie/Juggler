class TaskController < ApplicationController
	get '/projects/:project_id/tasks/new' do
  	if logged_in?
  		@project = Project.find(params[:project_id])

      erb :'tasks/new'
    else
    	redirect "/"
    end
  end

  post '/projects/:project_id/tasks' do
  	project = Project.find(params[:project_id])

  	project.tasks.build(name: params[:task_name], time_allocation: params[:time_allocation])

  	if project.tasks.last.save
			redirect "/projects/#{params[:project_id]}"
		else
			erb :'tasks/new'
		end
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