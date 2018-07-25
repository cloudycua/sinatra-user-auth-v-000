class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    # find the user who submitted the log in forms by looking in your database 
      #   for the user with the email and password from the params
      # sign them in by setting the session[:id] equal to the user's id
  
      # redirect the user to this route: get '/users/home' 
      #  that route is in the Users Controller. Go check out the code there.   
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    # log out the user by clearing the session hash here
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

end
