Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root "home#index"

  get '/search', to: 'search#index', as: 'search'
  resources :users do
    get 'dashboard', on: :member
    get 'profile', on: :member
    resources :watchlists
    resources :sale_transactions, only: [:index]  
  end
  resources :items do 
    resources :inquiries do
      resources :replies
    end
  end
  resources :watchlists
  resources :sale_transactions, only: [:show] do
    resources :feedbacks, only: [:index, :show] do
      resources :replies
    end
  end
  resources :feedbacks


  get "up" => "rails/health#show", as: :rails_health_check


end
