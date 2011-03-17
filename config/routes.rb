Geosight::Application.routes.draw do

    # Eventually we won't want the index of this controller
    # but it's good to have for testing
    resources :unassigned, :except => [:new, :create]
    match "upload" => 'unassigned#create', :via => "post"
    match "upload" => 'unassigned#new', :via => "get", :as => :new_unassigned
    
    resources :users, :except => [:index, :new, :show, :create], :path_names => {:edit => "account"}
    match "register" => "users#create", :via => "post"
    match "register" => "users#new", :via => "get", :as => :new_users_path
    match 'profile' => 'users#show', :via => "get", :as => :users_path
    
    resources :sessions, :only => [:new, :create, :destroy]
    match 'login' => 'sessions#create', :via => "post"
    match 'login' => 'sessions#new', :via => "get"
    match 'logout' => 'sessions#destroy', :via => "delete"
    
    resources :ratings, :only => [:create, :update, :destroy]
    
    resources :comments, :only => [:create, :update, :destroy]
    
    resources :tags, :only => [:show, :create, :destroy]
    
    resources :photos, :only => [:index, :show, :destroy]

    resources :sights, :only => [:index, :show, :destroy]
    
    match 'home' => "home#index", :via => "get"
    root :to => "home#index", :via => "get"
    
end
