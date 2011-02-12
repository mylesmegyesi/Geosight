Geosight::Application.routes.draw do

    # Eventually we won't want the index of this controller
    # but it's good to have for testing
    resources :uploads, :controller => :temp_photos, :as => :temp_photos
    
    resources :users, :except => [:index]
    resources :user_sessions, :except => [:index]

    resources :sights, :except => [:new, :create], :belongs_to => :user do
        resources :sight_comments
        resources :sight_ratings
        resources :photos, :except => [:new, :create] do
            resources :photo_comments
            resources :photo_tags
        end
    end
    
    match 'login' => 'user_sessions#create', :via => "post"
    match 'login' => 'user_sessions#new', :via => "get"
    match 'logout' => 'user_sessions#destroy', :via => "delete"
    match 'account' => 'users#edit', :via => "get"
    match 'register' => 'users#new', :via => "get"
    match 'home' => "home#index", :via => "get"
    root :to => "home#index", :via => "get"
    
end
