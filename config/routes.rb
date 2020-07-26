Rails.application.routes.draw do

  get 'restaurant/index'
  post 'mark_restaurant/create'
  get 'pages/home'
  get 'restaurant/index'

  # 開発用コード
  root to: 'restaurant#index'

  # 本番コード
  # root to: 'pages#home'
  devise_for :users

end