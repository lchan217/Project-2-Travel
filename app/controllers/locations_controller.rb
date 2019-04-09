class LocationsController < ApplicationController
  get '/locations/new' do
    @user = current_user
    erb :'/locations/new'
  end
  post'/locations' do
    @location = Location.create(params)
    @user = current_user
    @user.locations << @location #is this needed??
    redirect "/locations/#{@location.id}"
  end
  get '/locations/:id' do
    @location = Location.find(params[:id])
    erb :'/locations/show'
  end
  get '/locations/:id/edit' do
    @location = Location.find(params[:id])
    erb :'/locations/edit'
  end
  patch '/locations/:id' do
    @location = Location.find(params[:id])
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    @date = params[:date_visited]
    unless @country.empty? || @city.empty? || @attraction.empty? || @date.empty?
      params.delete("_method")
      @location.update(params)
      redirect "/locations/#{@location.id}"
    else
      redirect "/locations/#{@location[:id]}/edit"
    end
  end
  get '/locations/:id/delete' do
    @location = Location.find(params[:id])
   erb :'/locations/delete'
  end
  delete '/locations/:id/delete' do
   Location.find(params[:id]).destroy
   erb :'/locations/deleted'
  end

end
