# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :feeds, only: [:show]
  resources :streams, only: [:show]

  root to: 'welcome#reader'

  get 'chronological', to: 'welcome#chronological', as: :chronological
  get 'reader', to: 'welcome#reader', as: :reader
end
