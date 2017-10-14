Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"
  get "/products_manager", to: "static_pages#products_manager"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :products do
    resources :parameters, except: %i(index show)
  end
  resources :categories
end
