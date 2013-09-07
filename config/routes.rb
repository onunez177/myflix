Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'
   
  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
    #member do
    #  post 'result', to: 'videos#results'
    #end
  end
  

  resources :genres, only: [:show]


end
