# frozen_string_literal: true

Rails.application.routes.draw do
  resources :photos
  root 'pages#home'
  get '/about', to: 'pages#about'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :articles, param: :slug
  resources :users, except: [:new] do
    member do
      get :following, :followers
    end
  end

  resources :likes, only: %i[create destroy]
  resources :categories, except: [:destroy]
  resources :relationships, only: %i[create destroy]
end
