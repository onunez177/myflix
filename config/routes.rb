Myflix::Application.routes.draw do
  root to: 'pages#front'
    
  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  
  resources :genres, only: [:show]
  resources :users, only: [:create] 
  resources :sessions, only: [:create]
  resources :queued_videos, only: [:create] #will need to add update for updating queue and destroy for deleting queue item
 
  get 'my_queue', to: 'queued_videos#index'
  
  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
end
