Rails.application.routes.draw do
  devise_for :users
  resources :articles

  root "articles#index"

  resources :contacts, only: [:new, :create ]
  get '/contact', to: 'contacts#new', as: 'contact'
  get 'contacts/sent'

  get "about", to: "public#about"
  get "post", to: "public#post"
end
