require './config/environment'
class ProjectController < ApplicationController
  
  get '/projects' do
    erb :'projects/index'
  end
  
end