class GoalsController < ApplicationController
  get '/goals/new' do
    @user = current_user
    if logged_in?
      @user = current_user
      erb :'/goals/new'
    else
      @user = current_user
      redirect '/'
    end
  end
  post '/goals' do
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    params[:date_visited] = nil
    unless @country.empty? || @city.empty? || @attraction.empty?
      @goal = Goal.create(params)
      @user = current_user
      @user.goals << @goal 
      redirect "/goals/#{@goal.id}"
    else
      erb :'/goals/new'
    end
  end
  get '/goals/:id' do
    if logged_in?
      @goal = Goal.find(params[:id])
      erb :'/goals/show'
    else
      redirect '/'
    end
  end
  get '/goals/:id/edit' do
    if logged_in?
      @goal = Goal.find(params[:id])
      erb :'/goals/edit'
    else
      redirect '/'
    end
  end
  patch '/goals/:id' do
    @goal = Goal.find(params[:id])
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    unless @country.empty? || @city.empty? || @attraction.empty?
      params.delete("_method")
      @goal.update(params)
      redirect "/goals/#{@goal.id}"
    else
      redirect "/goals/#{@goal[:id]}/edit"
    end
  end
  get '/goals/:id/delete' do
    if logged_in?
      @goal = Goal.find(params[:id])
      erb :'/goals/delete'
    else
      redirect '/'
    end
  end
  delete '/goals/:id/delete' do
    Goal.find(params[:id]).destroy
    erb :'/goals/deleted'
  end
  get '/goals/:id/move' do
    if logged_in?
      @user = current_user
      @goal = Goal.find(params[:id])
      erb :'/goals/move'
    else
      redirect '/'
    end
  end
  patch '/goals/:id/move' do
    @user = current_user
    @completions = Completion.all
    @goals = Goal.all

    @goal = Goal.find(params[:id])
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    @date = params[:date_visited]

    unless @country.empty? || @city.empty? || @attraction.empty? || @date.empty?
      params.delete("_method")
      params.delete("id")
      @new_completion = Completion.create(params)
      @user.completions << @new_completion
      @goal.destroy
      erb :'/joint_index'
    else
      redirect "/goals/#{@goal[:id]}/move"
    end
  end
end
