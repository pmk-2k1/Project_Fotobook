Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root 'users#login'
  # root to: "home#index"
  
  # root "users#feed"
  root "guest#guest_photos"

    
  get "guest_photos", to: 'guest#guest_photos'
  get "guest_albums", to: 'guest#guest_albums'

  # get "/users/show" => "users#feed", :as => :user_root
  get 'feed', to:'users#feed'
  get 'feed_albums', to: 'users#feed_albums'

  get 'discover_photos', to: 'users#discover_photos'
  get 'discover_albums', to: 'users#discover_albums'

  resources :users, only: %i[show edit update]

  resources :users do
    resources :albums, :photos
  end

  resources :albums do
    resources :photos
  end

  get 'sign_up', to: 'users#sign_up'
  get 'sign_in', to: 'session#sign_in'
  post 'sign_in', to: 'session#create'
  # delete 'log_out', to: 'session#destroy'

  resources :users do
    member do
      post :follow, :unfollow
    end
  end

  resources :photos, :albums do
    member do
      post :like, :unlike
    end
  end

  resources :users do
    member do
      scope :profile do
        get :photos
        get :albums
        get :followings
        get :followers
      end
    end
  end

  namespace :admin do
    resources :users, :photos, :albums
  end
  
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  # as :user do
  #   get "sign_in" => "devise/sessions#new"
  #   post "sign_in" => "devise/sessions#create"
  #   delete "sign_out" => "devise/sessions#destroy"
  # end

  # devise_scope :user do
  #   get 'sign_in', to: 'devise/sessions#new'
  # end


end
