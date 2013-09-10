Myflix::Application.routes.draw do
  root to: 'pages#front'
    
  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
  end
  
  resources :genres, only: [:show]
  resources :users, only: [:create] 
  resources :sessions, only: [:create]
  
  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
end
