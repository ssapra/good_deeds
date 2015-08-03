Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :users, only: [:show, :update, :destroy]
  resources :legislators, only: [:index, :show]
  get '/good_deed' => 'bills#random_good_deed'

  resources :bills, only: :show, param: :bill_id


  resources :bookmarks, only: [:create, :index]
  delete '/bookmarks' => 'bookmarks#destroy'
end
