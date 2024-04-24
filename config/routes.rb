Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root "home#index"

  # config/routes.rb

# routes.rb
resources :categories do
  member do
    get 'subcategories'
  end
end



  get '/search', to: 'search#index', as: 'search'
  resources :users do
    get 'dashboard', on: :member
    get 'profile', on: :member
    resources :watchlists
    resources :sale_transactions, only: [:index]  
  end
  resources :items do 
    # resources :inquiries do
    #   resources :replies
    # end
  end
  resources :watchlists
  resources :sale_transactions, only: [:show] do
    resources :feedbacks, only: [:index, :show] do
      resources :replies
    end
  end
  resources :feedbacks
  resources :auctions do 
    resources :bids
    resources :inquiries do
      resources :replies
    end
  end
  resources :user_profiles
  get 'contact_page', to: 'contacts#new', as: 'contact_page'
  post 'contact_page', to: 'contacts#create'
  get '/error', to: 'errors#show', as: 'error'
  

  get "up" => "rails/health#show", as: :rails_health_check


end
