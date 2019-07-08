# frozen_string_literal: true

Rails.application.routes.draw do
  resources :photos
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
  resources :articles, param: :slug do
    resources :likes
  end
  resources :users, except: [:new] do
    member do
      get :following, :followers
    end
  end
  resources :categories, except: [:destroy]
  resources :relationships, only: %i[create destroy]
end
