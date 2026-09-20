Rails.application.routes.draw do
  devise_for :users

  resources :rooms

  get "/users/show", to: "users#show", as: :users_show
  get "/users/profile/edit", to: "users#edit_profile", as: :edit_profile
  patch "/users/profile", to: "users#update_profile", as: :update_profile
  
  root "rooms#index"

  # その他のRails生成ルート
end