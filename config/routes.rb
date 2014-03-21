require 'api_constraints'

Angularblog::Application.routes.draw do

  root 'home#index'

  devise_for :users

  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      devise_scope :user do
        match '/sessions' => 'sessions#create', :via => :post
        match '/sessions' => 'sessions#destroy', :via => :delete

        match '/passwords' => 'passwords#create', :via => :post
        match '/passwords' => 'passwords#update', :via => :put

      end

      resources :users, only: [:create]
      match '/users' => 'users#show', :via => :get
      match '/users' => 'users#update', :via => :put
      match '/users' => 'users#destroy', :via => :delete

    end    
  end

end
