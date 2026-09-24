Rails.application.routes.draw do
  devise_for :users

  get "/rooms/my_rooms", to: "rooms#my_rooms", as: :my_rooms

  get "/rooms/:room_id/reservation/new", to: "reservations#new", as: :new_room_reservation
  post "/rooms/:room_id/reservation", to: "reservations#create", as: :room_reservations
  post "/rooms/:room_id/reservation/complete", to: "reservations#complete", as: :complete_room_reservation
  get "/reservations", to: "reservations#index", as: :reservations
  delete "/reservations/:id", to: "reservations#destroy", as: :reservation
  
  resources :rooms

  root "rooms#index"

  get "/users/show", to: "users#show", as: :users_show
  get "/users/profile/edit", to: "users#edit_profile", as: :edit_profile
  patch "/users/profile", to: "users#update_profile", as: :update_profile
  
end
