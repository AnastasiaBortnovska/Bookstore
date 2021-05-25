# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  get '/users', to: redirect('/users/sign_up')

  root to: 'pages#index'
  
  resources :books, only: %i[index show]
  resources :users, only: %i[show update]
end
