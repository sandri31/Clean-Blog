Rails.application.routes.draw do
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  get "about", to: "public#about"
  get "contact", to: "public#contact"
  get "post", to: "public#post"
end
