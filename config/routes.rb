Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  resources :sectors
  
  resources :sectors do
    resources :industries, only: [:index, :create] # Nested routes if needed
  end
  resources :industries, only: [:show, :update, :destroy]

  resources :industries do
    resources :stocks, only: [:index, :create] # Nested routes if you want
  end
  resources :stocks, only: [:show, :update, :destroy]
  
  resources :deliveries, only: [] do
    collection do
      get 'fetch', to: 'deliveries#fetch_delivery'
    end
  end
end
