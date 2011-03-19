# Geosight

Geosight combines the adventure of geocaching with the art of photography using upcoming photo geotagging technology. Traditional geocaching involves writing in a log book at each cache location. Geosight involves taking a photo at each 'sight' location, encouraging interesting and beautiful 'sights'. Geosight will harness EXIF GPS data included in photos taken by modern digitial cameras and mobile phones.

## Requirements

* Ruby 1.8.7
* SQLite 3
* ImageMagick (for converting uploaded images)
* Git

## Installation

Install Rails

    sudo gem install rails

Checkout the code

    git clone git@github.com:mylesmegyesi/Geosight.git

Install the gems needed by the app

    sudo bundle install

Migrate the database

    rake db:migrate

You should now be able to start the server

    rails server

In a browser, navigate to

    http://localhost:3000

## API

POST   /users(.:format)                
GET    /users/register(.:format)       
GET    /users/:id/settings(.:format)   
GET    /users/:id(.:format)            
PUT    /users/:id(.:format)            
DELETE /users/:id(.:format)            
POST   /user_sessions(.:format)        
GET    /user_sessions/new(.:format)    
DELETE /user_sessions/:id(.:format)    
GET    /login(.:format)                
DELETE /logout(.:format)               
POST   /ratings(.:format)              
PUT    /ratings/:id(.:format)          
DELETE /ratings/:id(.:format)          
POST   /comments(.:format)             
PUT    /comments/:id(.:format)         
DELETE /comments/:id(.:format)         
POST   /tags(.:format)                 
GET    /tags/:id(.:format)             
DELETE /tags/:id(.:format)             
GET    /photos/unassigned(.:format)    
GET    /photos(.:format)               
POST   /photos(.:format)               
GET    /photos/new(.:format)           
GET    /photos/:id/edit(.:format)      
GET    /photos/:id(.:format)           
PUT    /photos/:id(.:format)           
DELETE /photos/:id(.:format)           
GET    /upload(.:format)               
GET    /sights(.:format)               
GET    /sights/:id(.:format)           
DELETE /sights/:id(.:format)           
GET    /home(.:format)                 
GET    /(.:format)                     
GET    /not_found(.:format)            
GET    /unprocessable_entity(.:format) 
GET    /internal_server_error(.:format) 
       /*path(.:format)                