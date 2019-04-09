class GoalsController < ApplicationController
  get '/goals/new' do
    "goals new page"
  end
  get '/goals/:id' do
    "goals id specific"
  end
end
