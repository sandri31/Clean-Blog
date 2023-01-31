# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get '/contact', to: 'contacts#new', as: 'contact'
  get 'contacts/sent'
  get 'about', to: 'public#about'

  root 'articles#index'
  resources :contacts, only: %i[new create]
  resources :articles do
    get 'post', to: 'articles#post'
  end
end
