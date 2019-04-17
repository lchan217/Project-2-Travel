class CompletionsController < ApplicationController
  get '/completions/new' do
    if logged_in?
      @user = current_user
      erb :'/completions/new'
    else
      redirect '/'
    end
  end
  post'/completions' do
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    @date = params[:date_visited]
    unless @country.empty? || @city.empty? || @attraction.empty? || @date.empty?
      @completion = Completion.create(params)
      @user = current_user
      @user.completions << @completion #needed or else @user.completions wont work
      redirect "/completions/#{@completion.id}"
    else
      erb :'/completions/new'
    end
  end
  get '/completions/:id' do
    if logged_in?
      @completion = Completion.find(params[:id])
      erb :'/completions/show'
    else
      redirect '/'
    end
  end
  get '/completions/:id/edit' do
    if logged_in?
      @completion = Completion.find(params[:id])
      erb :'/completions/edit'
    else
      redirect '/'
    end
  end
  patch '/completions/:id' do
    @completion = Completion.find(params[:id])
    @city = params[:city]
    @country = params[:country]
    @attraction = params[:tourist_attraction]
    @date = params[:date_visited]
    unless @country.empty? || @city.empty? || @attraction.empty? || @date.empty?
      params.delete("_method")
      @completion.update(params)
      redirect "/completions/#{@completion.id}"
    else
      redirect "/completions/#{@completion[:id]}/edit"
    end
  end
  get '/completions/:id/delete' do
    if logged_in?
      @completion = Completion.find(params[:id])
      erb :'/completions/delete'
    else
      redirect '/'
    end
  end
  delete '/completions/:id/delete' do
     Completion.find(params[:id]).destroy
     erb :'/completions/deleted'
  end

end
