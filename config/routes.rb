Patchwork::Application.routes.draw do
  root 'home#index'

  # Regular routes
  match '/login'    => 'home#login',    :via => [:get, :post]
  match '/register' => 'home#register', :via => [:get, :post]
  get '/logout'     => 'home#logout'
  get '/account'    => 'home#account'

  # Special routes
  get '/patches/:id/implement'     => 'implementations#new', :as => :new_implementation
  post '/implementations/:id/vote' => 'implementations#vote', :as => :vote_for_implementation

  # Resource routes
  resources :users
  resources :patches
  resources :implementations
end
