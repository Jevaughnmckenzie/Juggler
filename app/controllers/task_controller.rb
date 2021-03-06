require './config/environment'

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
  	@project = Project.find(params[:project_id])

  	@project.tasks.build(name: params[:task_name], time_allocation: params[:time_allocation])

    @task = @project.tasks.last

  	if @task.save
			redirect "/projects/#{params[:project_id]}"
		else
      @errors = @task.errors
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
  		@project = Project.find(params[:project_id])
  		@task = Task.find(params[:id])
      erb :'tasks/edit'
    else
    	redirect '/'
    end
  end

  patch '/projects/:project_id/tasks/:id' do
  	# project = Project.find(params[:project_id])
  	@task = Task.find(params[:id])

  	@task.name = params[:task_name]
  	@task.time_allocation = params[:time_allocation]

  	if @task.save
  		redirect "/projects/#{params[:project_id]}"
  	else
      @project = Project.find(params[:project_id])
  		@errors = @task.errors
  		erb :'tasks/edit'
  	end
  end

  delete '/projects/:project_id/tasks/:id/delete' do
  	task = Task.find(params[:id])
  	task.delete

  	redirect "/projects/#{params[:project_id]}"
  end

  helpers do 
		def validate_task_access
      @task = Task.find(params[:id])
      unless current_user.tasks.include?(@task)    
        redirect '/projects'
      end
    end
	end

end