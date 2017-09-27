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

  		@errors = user.errors
  	  erb :'registrations/signup'
  	end
  end

  get '/login' do
    if logged_in?
      # binding.pry
      redirect '/projects'
    else
      erb :'sessions/login'
    end
    
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect '/projects'
    elsif user.nil?
    	@errors = ["No user exists by that name"]

    	erb :'sessions/login' 
    else
      @errors = user.errors

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
      begin
        User.find(session[:user_id]) 
      rescue
        nil
      end
  	end
  end
end