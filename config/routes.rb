Rails.application.routes.draw do
  get 'home/top'
  get '/search', to: 'search#search'
  get 'charts/monthly'
  get '/events', to: 'events#index'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, except: [:edit, :update, :new, :create]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    # 退会機能
    member do
      get "unsubscribe"
      patch "withdraw"
      get "following"
      get "follower"
    end
  end

  root to: 'home#top'
end
