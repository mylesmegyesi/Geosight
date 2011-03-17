Geosight::Application.routes.draw do

    # Eventually we won't want the index of this controller
    # but it's good to have for testing
    resources :unassigned, :except => [:new, :edit, :create]
    match "upload" => 'unassigneds#create', :via => "post"
    match "upload" => 'unassigneds#new', :via => "get", :as => :new_unassigned
    
    resources :users, :except => [:index], :path_names => {:edit => "settings", :new => "register"}
    
    resources :user_sessions, :only => [:new, :destroy]
    match 'login' => 'user_sessions#new', :via => "get"
    match 'logout' => 'user_sessions#destroy', :via => "delete"
    
    resources :ratings, :only => [:create, :update, :destroy]
    
    resources :comments, :only => [:create, :update, :destroy]
    
    resources :tags, :only => [:show, :create, :destroy]

    resources :sights, :only => [:index, :show, :destroy] do 
        resources :photos, :only => [:index, :show, :destroy]
    end
    
    match 'home' => "home#index", :via => "get"
    root :to => "home#index", :via => "get"
    
end
