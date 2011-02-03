Geosight::Application.routes.draw do

    resources :sights do
        resources :sight_comments
        resources :sight_ratings
        resources :photos do
            resources :photo_comments
            resources :photo_tags
        end
    end
    
    resources :users

    match 'login' => 'user_sessions#create', :via => "post"
    match 'login' => 'user_sessions#new', :via => "get"
    match 'logout' => 'user_sessions#destroy', :via => "delete"
    match 'account' => 'users#edit', :via => "get"
    match 'register' => 'users#new', :via => "get"
    root :to => 'users#show', :via => "get"
    
end
