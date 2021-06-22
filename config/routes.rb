# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  devise_scope :user do
    put '/users/edit',  to: 'users/registrations#update', as: :user_edit
  end
  
  root to: 'pages#index'
  
  resources :books, only: %i[index show]
  resources :users, only: %i[show update destroy]
  resources :addresses, only: %i[create update]
  resources :reviews, only: [:create]
  resources :order_books, only: [:index, :create, :update, :destroy]
  resources :coupons, only: :update
  resources :authenticate_users, only: [:show, :create]
  resources :checkout, only: [:show, :update]
end
