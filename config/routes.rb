# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create update destroy] do
    resources :trips, only: %i[index show create update destroy]
  end

  resources :trips, only: %i[show] do
    resources :events, only: %i[index show create update destroy]
  end
end
