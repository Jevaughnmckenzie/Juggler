require './config/environment'
class ProjectController < ApplicationController
  
  get '/projects' do
  	if logged_in?
  	  user = User.find(current_user)
      @projects = user.projects
      erb :'projects/index'
    else
  	  redirect '/'
    end
  end

  
  
end