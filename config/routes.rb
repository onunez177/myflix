Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  
  root to: 'ui#index'
  
  resources :videos, only: [:show]
  resources :genres, only: [:show]
end
