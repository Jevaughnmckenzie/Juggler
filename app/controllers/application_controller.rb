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
  
  # binding.pry
  	if logged_in?
  		# binding.pry
  	  redirect '/projects'
  	else
  	  erb :'registrations/signup'
  	end
  end

  post '/signup' do
  	user = User.new(username: params[:username], password: params[:password])

  	if user.save
  	  
  	  session[:user_id] = user.id
  	  # binding.pry
  	  redirect '/projects'
  	else
  	  redirect '/signup'
  	end
  end

  get '/login' do
    if logged_in?
      # binding.pry
      redirect '/projects'
    else
      erb erb :'sessions/login'
    end
    
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect '/projects'
    else
      @login_error = "Username or password is incorrect"

      erb :'sessions/login'
    end
  end

  post '/logout' do
    session.clear

    redirect '/'
  end
  

  helpers do 
  	def logged_in?
  	  !!current_user
  	end

  	def current_user
      session[:user_id]
  	end
  end
end