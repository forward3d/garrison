Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :alerts

  namespace :api do
    namespace :v1 do
      resources :alerts, only: [:index, :create, :show, :update]
      resources :sources, only: [:index, :create, :show, :update]
    end
  end
end
