Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :restaurants
  resources :tables
  resources :users
  get '/', to: "main#main", as: 'main'
  get 'login', to: "main#login", as: 'login'
  post 'login', to: "main#logging_in"
  get 'register', to: "main#register", as: 'register'
  post 'register', to: "users#create"
  get 'logout', to: "main#logout", as: 'logout'
  get 'home', to: "main#home", as: 'home'

  get 'appointment/:restaurant_name', to: "appointments#makeappointment", as: 'makeappointment'
  get 'appointment/:id/delete', to: "appointments#delete", as: 'deleteappointment'
  
  get 'favorite', to: "favorites#listfavorite", as: 'listfavorite'
  post 'restaurant/:id/favorite', to: "favorites#submitfavorite", as: 'submitfavorite'
  get 'favorite/:restaurant_name/delete', to: "favorites#delete", as: 'deletefavorite'
  
  get 'profile', to: "users#profile", as: 'profile'
  post 'profile/submit', to: "users#submitprofile", as: 'submitprofile'
  
  get 'restaurant/list', to: "restaurants#listrestaurant", as: 'listrestaurant'
  get 'restaurant/:restaurant_name', to: "restaurants#showrestaurant", as: 'showrestaurant'
  get 'restaurant/id/:restaurant_id', to: "restaurants#showrestaurantid", as: 'showrestaurantid'
  
  post 'comment/:id/like', to: "likes#makelike", as: 'makelike'
  
  get 'rate/:restaurant_name', to: "rates#makerate", as: 'makerate'
  post 'rate/:restaurant_name/submit', to: "rates#submitrate", as: 'submitrate'
  
  get 'comment/:restaurant_name', to: "comments#makecomment", as: 'makecomment'
  get 'comment/:id/delete', to: "comments#delete", as: 'deletecomment'
end
