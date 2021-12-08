Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :restaurants
  resources :tables
  resources :users
  #main
  get '/', to: "main#main", as: 'main'
  get 'login', to: "main#login", as: 'login'
  post 'login', to: "main#submitlogin", as: 'submitlogin'
  get 'register', to: "main#register", as: 'register'
  post 'register', to: "main#submitregister", as: 'submitregister'
  get 'logout', to: "main#logout", as: 'logout'
  get 'home', to: "main#home", as: 'home'
  #appointment
  get 'appointment/:restaurant_name', to: "appointments#makeappointment", as: 'makeappointment'
  post 'appointment/:restaurant_name/submit', to: "appointments#submitappointment", as: 'submitappointment'
  get 'appointment/:id/delete', to: "appointments#delete", as: 'deleteappointment'
  #comment
  get 'comment/:restaurant_name', to: "comments#makecomment", as: 'makecomment'
  post 'comment/:restaurant_name/submit', to: "comments#submitcomment", as: 'submitcomment'
  get 'comment/:id/delete', to: "comments#delete", as: 'deletecomment'
  #favorite
  get 'favorite', to: "favorites#listfavorite", as: 'listfavorite'
  post 'restaurant/:id/favorite', to: "favorites#submitfavorite", as: 'submitfavorite'
  get 'favorite/:restaurant_name/delete', to: "favorites#delete", as: 'deletefavorite'
  #like
  post 'comment/:id/like', to: "likes#submitlike", as: 'submitlike'
  #rate
  get 'rate/:restaurant_name', to: "rates#makerate", as: 'makerate'
  post 'rate/:restaurant_name/submit', to: "rates#submitrate", as: 'submitrate'
  #restaurant
  get 'restaurant/list', to: "restaurants#listrestaurant", as: 'listrestaurant'
  get 'restaurant/:restaurant_name', to: "restaurants#showrestaurant", as: 'showrestaurant'
  get 'restaurant/id/:restaurant_id', to: "restaurants#showrestaurantid", as: 'showrestaurantid'
  #user
  get 'profile', to: "users#profile", as: 'profile'
  post 'profile', to: "users#submitprofile", as: 'submitprofile'
  get 'account/delete', to: "users#delete", as: 'deleteuser'
  
end
