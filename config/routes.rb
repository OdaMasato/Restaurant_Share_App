Rails.application.routes.draw do

  get 'pages/home'

  get 'users/show'
  get 'users/index'

  get 'follows/create'
  get 'follows/update'
  get 'follows/destroy'

  get 'restaurants/index'
  get 'restaurants/show'

  post 'mark_restaurants/create'
  post 'mark_restaurants/destroy'

  post 'went_restaurants/create'
  post 'went_restaurants/destroy'

  root to: 'pages#home'


  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
