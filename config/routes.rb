Myflix::Application.routes.draw do
  root to: 'pages#front'
    
  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  
  resources :genres, only: [:show]
  resources :users, only: [:create, :show] 
  resources :sessions, only: [:create]
  resources :queued_videos, only: [:create, :destroy] 
  
  resources :relationships, only: [:create, :destroy]
  get 'people', to: 'relationships#index'
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  get 'confirm_password_reset', to: 'password_resets#confirm' 
  
  resources :invites, only: [:new, :create] do
    resources :users, only: [:new]
  end
  

  get 'my_queue', to: 'queued_videos#index'
  post 'update_queue', to: 'queued_videos#update'

  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
end
