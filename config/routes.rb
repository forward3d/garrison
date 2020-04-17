Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "alerts#index"

  resources :alerts do
    member do
      post :unverify
      post :verify
      post :reject
      post :resolve
    end
  end

  resources :runs, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :agents, only: [:index, :create, :show]
      resources :alerts, only: [:index, :create, :show] do
        collection do
          post :obsolete
        end
      end
      resources :runs, only: [:index, :create, :update, :show]
    end
  end

  health_check_routes
end
