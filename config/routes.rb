# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v2 do
      resources :feeds, only: [:show]
    end

    namespace :v3 do
      resources :feeds
      resources :streams
      resources :stream_assignments, only: [:create, :destroy]
      resources :entries, only: [:index]
    end
  end

  resources :feeds, only: [:show]
  resources :streams, only: [:show]

  root to: 'welcome#index'
  get 'chronological', to: 'welcome#chronological', as: :chronological
  get 'reader', to: 'welcome#reader', as: :reader
end
