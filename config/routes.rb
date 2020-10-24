Rails.application.routes.draw do

  # resources :users , only: [:index, :show]
  # resources :follows, only: [:create, :update, :destroy]
  # resources :restaurants, only: [:index, :show]
  # resources :mark_restaurants, only: [:create, :update, :destroy]
  # resources: went_restaurants, only: [:create, :destroy]

  get 'pages/index'

  get 'users/index'
  get 'users/show'

  get 'follows/create'
  get 'follows/update'
  get 'follows/destroy'

  get 'restaurants/index'
  get 'restaurants/show'

  get 'mark_restaurants/index'
  post 'mark_restaurants/create'
  post 'mark_restaurants/update'
  post 'mark_restaurants/destroy'

  post 'went_restaurants/create'
  post 'went_restaurants/destroy'

  # root to: 'pages#index'
  root to: 'mark_restaurants#index'


  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
