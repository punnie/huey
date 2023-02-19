# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v2 do
      resources :feeds, only: [:show]
    end
  end

  resources :feeds, only: [:show]

  root to: 'welcome#index'
  get 'chronological', to: 'welcome#chronological', as: :chronological
end
