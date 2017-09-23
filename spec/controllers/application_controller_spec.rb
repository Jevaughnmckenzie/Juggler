require "spec_helper"

describe ApplicationController do 
  
  before do 
    user1 = User.create(username: "user1", password: "password")
    project1 = Project.create(name: "First Project")
    task1 = Task.create(name: "Create Juggler")
    task2 = Task.create(name: "Work on Juggler")
  end

  after do
  	User.destroy_all
  	Project.destroy_all
  	Task.destroy_all
  end

  describe "Homepage" do 
    it 'loads the homepage' do 
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Juggler")
    end

    
  end

  describe "Signup Page" do
    
    it 'loads the signup page' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'directs a signed up user to the projects index' do
      params = {
      	:username => "skittles",
      	:password => "password"
      }
      post '/signup', params
      expect(last_response.location).to include("/projects")
    end

    it 'does not let a user sign up without a username' do
      params = {
      	:username => "",
      	:password => "password"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a user sign up without a password' do
      params = {
      	:username => "skittles",
      	:password => ""
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a user sign up with a username already in use' do
      params = {
      	:username => "user1",
      	:password => "userpass"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a user sign up with a password less than 6 characters long' do
      params = {
      	:username => "skitles",
      	:password => "5char"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a logged in user see the sign up page' do
      user2 = User.create(username: "user2", password: "password")
      params = {
      	:username => "user2",
      	:password => "password"
      }

      post '/signup', params
      session = {}
      session[:user_id] = user2.id

      get '/signup'

      expect(last_response.location).to include('/projects')
    end
  end

end