Rails.application.routes.draw do
  devise_for :users

  get '/contact', to: 'contacts#new', as: 'contact'
  get 'contacts/sent'
  get "about", to: "public#about"

  root "articles#index"
  resources :contacts, only: [:new, :create ]
  scope module: 'users' do
    resources :articles do
      # Ajoute une route vers post
      get "post", to: 'articles#post'
    end
  end
end
