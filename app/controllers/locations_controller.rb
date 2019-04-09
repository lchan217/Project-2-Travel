class LocationsController < ApplicationController
  get '/index' do
  end
  get '/locations/new' do
    erb :'/locations/new'
  end
  get '/locations/:id' do
    @location = Location.find(params[:id])
    erb :show
  end


end
