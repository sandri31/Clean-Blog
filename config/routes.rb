# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get '/contact', to: 'contacts#new', as: 'contact'
  get 'contacts/sent'
  get 'about', to: 'public#about'

  # Route Stripe webhooks and checkout session
  get 'webhooks/stripe'
  post '/webhooks/stripe', to: 'webhooks#stripe'
  post '/create-checkout-session', to: 'payments#create_checkout_session'

  root 'articles#index'
  resources :contacts, only: %i[new create]
  resources :categories, only: [:show]
  resources :subscribers, only: [:create], param: :token do
    member do
      get :unsubscribe
    end
  end
  resources :articles do
    post :search, on: :collection
  end
end
