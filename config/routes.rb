Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"

  get '/search', to: 'search#index', as: 'search'
  resources :users do
    get 'dashboard', on: :member
    resources :watchlists
  end
  resources :items
  resources :watchlists
  resources :feedbacks


  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
