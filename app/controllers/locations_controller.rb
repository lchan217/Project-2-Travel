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
  get '/locations/:id/edit' do
    erb :'/locations/edit'
  end
  patch '/locations/:id' do
    @location = Location.find(params[:id])
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    @date = params[:date_visited]
    unless @location.empty? || @city.empty? || @attraction.empty? || @date.empty?
      params.delete("_method")
      @location.update(params)
      redirect "/locations/#{@location.id}"
    else
      redirect "/locations/#{@location[:id]}/edit"
    end
  end
  delete '/locations/:id/delete' do
   Location.find(params[:id]).destroy
   erb :'/locations/delete'
  end

end
