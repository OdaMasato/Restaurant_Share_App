Rails.application.routes.draw do

  get 'pages/home'

  # ☆見直す
  get 'restaurant_infos/new'
  get 'restaurant_infos/create'
  get 'mark_restaurants/create'

  # 開発用コード
  root to: 'restaurant_infos#new'

  # 本番コード
  # root to: 'pages#home'
  devise_for :users

end