# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'
  resources :articles

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # post 'users', to: 'users#create'
  resources :users, expect: [:new]
end
