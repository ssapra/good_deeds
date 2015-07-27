Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :users, only: [:show, :update, :destroy]
  resources :legislators, only: [:index, :show]
end
