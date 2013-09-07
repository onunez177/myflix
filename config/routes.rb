Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'
   
  resources :videos, only: [:show, :index]
  resources :genres, only: [:show]
end
