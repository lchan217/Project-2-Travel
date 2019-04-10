class GoalsController < ApplicationController
  get '/goals/new' do
    if logged_in?
      @user = current_user
      erb :'/goals/new'
    else
      redirect '/login'
    end
  end
  post '/goals' do
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    unless @country.empty? || @city.empty? || @attraction.empty?
      @goal = Goal.create(params)
      @user = current_user
      @user.goals << @goal #needed or else @user.goals wont work
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
      redirect '/login'
    end
  end
  get '/goals/:id/edit' do
    if logged_in?
      @goal = Goal.find(params[:id])
      erb :'/goals/edit'
    else
      redirect '/login'
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
      redirect '/login'
    end
  end
  delete '/goals/:id/delete' do
    Goal.find(params[:id]).destroy
    erb :'/goals/deleted'
  end
end
