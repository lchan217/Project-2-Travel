class LocationsController < ApplicationController
  get '/index' do
  end
  get '/locations/new' do
    erb :'/locations/new'
  end
  post'/locations' do
    #{"city"=>"Bangkok", "country"=>"Thailand", "tourist_attraction"=>"Aquarium", "date_visited"=>"December 2017"}
    @location = Location.create(params)
    @user = User.find(session[:user_id])
    @user.locations << @location
    redirect "/locations/#{@location.id}"
  end
  get '/locations/:id' do
    @location = Location.find(params[:id])
    erb :'/locations/show'
  end


end
