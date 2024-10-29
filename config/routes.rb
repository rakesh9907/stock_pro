Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  resources :sectors do
    collection do
      get "test", to: 'sectors#test'
    end
  end
  
  resources :sectors do
    resources :industries, only: [:index, :create]
  end
  resources :industries, only: [:show, :update, :destroy]

  resources :industries do
    resources :stocks, only: [:create]
    member do
      get 'industry_stocks', to: 'stocks#industry_stocks'
    end
  end
  resources :stocks, only: [:index,:show, :update, :destroy]
  
  resources :deliveries, only: [] do
    collection do
      get 'fetch', to: 'deliveries#fetch_delivery'
      get 'weekly', to: 'deliveries#weekly_delivery'
      get 'sector', to: 'deliveries#delivery_sector'
      get 'industries', to: 'deliveries#delivery_industry'
      get 'stock', to: 'deliveries#delivery_stock'
    end
  end

  resources :bookmarks do
    resources :sub_bookmarks
  end
end
