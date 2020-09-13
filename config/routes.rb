Rails.application.routes.draw do

  get 'users/show'
  get 'users/index'

  get 'follows/index'
  post 'follows/create'
  post 'follows/show'
  post 'follows/destroy'

  get 'restaurants/index'
  get 'restaurants/show'
  
  get 'mark_restaurants/new'
  post 'mark_restaurants/create'
  post 'mark_restaurants/destroy'

  post 'went_restaurants/new'
  post 'went_restaurants/create'
  post 'went_restaurants/destroy'


  # 開発用コード
  root to: 'restaurants#index'
  # 本番コード
  # root to: 'pages#home'

  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
