require './config/environment'

class ApplicationController < Sinatra::Base
  configure do 
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'secret'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
  	erb :'registrations/signup'
  end

  post '/signup' do
  	user = User.new(username: params[:username], password: params[:password])

  	if user.save
  	  redirect '/projects'
  	else
  	  redirect '/signup'
  	end

  	
  end
end