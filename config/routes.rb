# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  scope 'articles' do
    put '/:id' => 'articles#update'
  end

  # post 'users', to: 'users#create'
  resources :articles, param: :slug
  resources :users, except: [:new]
  resources :categories, except: [:destroy]
end
