Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, only: []

  namespace :api do
    namespace :v2 do
      resources :aggregations do
        resources :entries, only: [:index]
      end

      resources :feeds do
        resources :entries, only: [:index]
      end

      resources :subscriptions

      resources :entries, only: [:show]
    end
  end
end
