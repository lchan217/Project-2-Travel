class UsersController < ApplicationController
  get '/signup' do
      erb :'/users/create_user'
  end
  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id        @completions = Completion.all
      @goals = Goal.all
      erb :'/joint_index'
    else
      erb :'users/error'
    end
  end

  get '/login' do
      erb :'/users/login'
  end
  post '/login' do
     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password]) #if you can find a user AND authenticate then log them in
        session[:user_id] = @user.id
        erb :joint_index
      elsif
        @user == nil
        erb :'/users/nil_error'
      elsif
        !@user.authenticate(params[:password])
        erb :'/users/pw_error'
      else
        erb :'/users/error'
     end
  end
  get '/joint_index' do
   if logged_in?
     @user = User.find(session[:user_id])
      erb :joint_index
    else
      erb :'/users/error'
    end
  end

  post '/logout' do
    redirect '/logout'
  end
  get '/logout' do
    session.clear
    erb :index
  end
end
