Twitter::Application.routes.draw do
  get 'search/index'

  root 'about#index'
  match '/about',   to: 'about#index',      via: 'get'
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/search',  to: 'search#index',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :users do
  	member do
  		get :following, :followers
  	end
  end

  resources :relationships, only: [:create, :destroy]
  resources :tweets
  resources :sessions, only: [:new, :create, :destroy]
  #resources :microposts, only: [:create, :destroy]
 end
