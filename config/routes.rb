Rails.application.routes.draw do
  get 'restaurants/index'
  get 'restaurants/show'
  post 'mark_restaurants/new'
  post 'mark_restaurants/create'
  post 'mark_restaurants/destroy'
  post 'went_restaurants/create'
  post 'went_restaurants/destroy'

  # 開発用コード
  root to: 'restaurants#index'
  # 本番コード
  # root to: 'pages#home'

  devise_for :users
end
