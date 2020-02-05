# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show create update destroy] do
    resources :trips, only: %i[index show create update destroy]
  end
end
