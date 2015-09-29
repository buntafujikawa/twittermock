Twitter::Application.routes.draw do
  root 'about#index'
  match '/about',   to: 'about#index',      via: 'get'
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/search',  to: 'search#index',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :users do
  	member do
  		get :following, :followers, :favorite
  	end
  end

  resources :tweets do
  	member do
  		get :favorites
  		# /tweets/:id/reply
  		post :reply
      post :retweet
  	end
  end


  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
 end
