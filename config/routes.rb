Geosight::Application.routes.draw do
    
    resources :users, :except => [:index], :path_names => {:edit => "settings", :new => "register"}
    
    resources :user_sessions, :only => [:new, :create, :destroy]
    match "login" => "user_sessions#new", :via => "get"
    match "logout" => "user_sessions#destroy", :via => "delete"
    
    resources :ratings, :only => [:create, :update, :destroy]
    
    resources :comments, :only => [:create, :update, :destroy]
    
    resources :tags, :only => [:show, :create, :destroy]
    
    resources :photos, :except => [:edit, :update]
    
    resources :sights
    
    match "home" => "home#index", :via => "get"
    root :to => "home#index", :via => "get"
    
    match "not_found" => "errors#not_found", :via => "get"
    match "unprocessable_entity" => "errors#unprocessable_entity", :via => "get"
    match "internal_server_error" => "erros#internal_server_error", :via => "get"
    
    match '*path', :controller => :errors, :action => :not_found
    
end
