Rails.application.routes.draw do
  resources :reminders
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :medicines, only: [:show]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :alerts do
    resources :reports, only: [:new, :create]
  end
end
