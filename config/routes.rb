Rails.application.routes.draw do
  get 'restaurants/index'
  post 'mark_restaurants/create'
  post 'mark_restaurants/destroy'

  # 開発用コード
  root to: 'restaurants#index'

  # 本番コード
  # root to: 'pages#home'
  devise_for :users
end
