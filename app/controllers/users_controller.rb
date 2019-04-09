class UsersController < ApplicationController
  get '/signup' do
      erb :'/users/create_user'
  end
  post '/signup' do
    @name = params[:name]
    @username = params[:username]
    @email = params[:email]
    @password = params[:password]

    unless @name.empty? || @username.empty? || @email.empty? || @password.empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      @locations = Location.all
      erb :'/locations/index'
    else
      erb :'users/error'
    end
  end

  get '/login' do
      erb :'/users/login'
  end
  post '/login' do
     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        @locations = Location.all
        erb :'/locations/index'
     else
        erb :'/users/error'
     end
  end
  post '/user/logout' do
    redirect '/logout'
  end
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end
end
