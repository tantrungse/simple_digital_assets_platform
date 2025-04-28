Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "home#index"

  namespace :creator do
    resources :assets, only: [:index] do
      collection { post :bulk_import }
    end
  end

  namespace :customer do
    resources :purchases, only: [:index, :create] do
      collection { get :shop }
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        get "creator_earnings", to: "creator_earnings#index"
      end
    end
  end
end
