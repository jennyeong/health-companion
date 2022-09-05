Rails.application.routes.draw do
  resources :reminders
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  get "/scanning", to: "pages#scanning"
  post "/medicine", to: "medicines#scanning"
  get "/successful", to: "pages#successful"

  resources :medicines, only: [:show]
  # Defines the root path route ("/")
  # root "articles#index"


  resources :reports, only: [:new, :create, :index, :show]
end
