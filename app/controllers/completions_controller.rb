class CompletionsController < ApplicationController
  get '/completions/new' do
    @user = current_user
    erb :'/completions/new'
  end
  post'/completions' do
    @completion = Completion.create(params)
    @user = current_user
    @user.completions << @completion #is this needed??
    redirect "/completions/#{@completion.id}"
  end
  get '/completions/:id' do
    @completion = Completion.find(params[:id])
    erb :'/completions/show'
  end
  get '/completions/:id/edit' do
    @completion = Completion.find(params[:id])
    erb :'/completions/edit'
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
    @completion = Completion.find(params[:id])
   erb :'/completions/delete'
  end
  delete '/completions/:id/delete' do
   Completion.find(params[:id]).destroy
   erb :'/completions/deleted'
  end

end
