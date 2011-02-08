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

GET    /sights/:sight\_id/sight\_comments(.:format)  
POST   /sights/:sight\_id/sight\_comments(.:format)  
GET    /sights/:sight\_id/sight\_comments/new(.:format)  
GET    /sights/:sight\_id/sight\_comments/:id/edit(.:format)  
GET    /sights/:sight\_id/sight\_comments/:id(.:format)  
PUT    /sights/:sight\_id/sight\_comments/:id(.:format)  
DELETE /sights/:sight\_id/sight\_comments/:id(.:format)  
GET    /sights/:sight\_id/sight\_ratings(.:format)  
POST   /sights/:sight\_id/sight\_ratings(.:format)  
GET    /sights/:sight\_id/sight\_ratings/new(.:format)  
GET    /sights/:sight\_id/sight\_ratings/:id/edit(.:format)  
GET    /sights/:sight\_id/sight\_ratings/:id(.:format)  
PUT    /sights/:sight\_id/sight\_ratings/:id(.:format)  
DELETE /sights/:sight\_id/sight\_ratings/:id(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_comments(.:format)  
POST   /sights/:sight\_id/photos/:photo\_id/photo\_comments(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_comments/new(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_comments/:id/edit(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_comments/:id(.:format)  
PUT    /sights/:sight\_id/photos/:photo\_id/photo\_comments/:id(.:format)  
DELETE /sights/:sight\_id/photos/:photo\_id/photo\_comments/:id(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_tags(.:format)  
POST   /sights/:sight\_id/photos/:photo\_id/photo\_tags(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_tags/new(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_tags/:id/edit(.:format)  
GET    /sights/:sight\_id/photos/:photo\_id/photo\_tags/:id(.:format)  
PUT    /sights/:sight\_id/photos/:photo\_id/photo\_tags/:id(.:format)  
DELETE /sights/:sight\_id/photos/:photo\_id/photo\_tags/:id(.:format)  
GET    /sights/:sight\_id/photos(.:format)  
POST   /sights/:sight\_id/photos(.:format)  
GET    /sights/:sight\_id/photos/new(.:format)  
GET    /sights/:sight\_id/photos/:id/edit(.:format)  
GET    /sights/:sight\_id/photos/:id(.:format)  
PUT    /sights/:sight\_id/photos/:id(.:format)  
DELETE /sights/:sight\_id/photos/:id(.:format)  
GET    /sights(.:format)  
POST   /sights(.:format)  
GET    /sights/new(.:format)  
GET    /sights/:id/edit(.:format)  
GET    /sights/:id(.:format)  
PUT    /sights/:id(.:format)  
DELETE /sights/:id(.:format)  
GET    /users(.:format)  
POST   /users(.:format)  
GET    /users/new(.:format)  
GET    /users/:id/edit(.:format)  
GET    /users/:id(.:format)  
PUT    /users/:id(.:format)  
DELETE /users/:id(.:format)  
POST   /login(.:format)  
GET    /login(.:format)  
DELETE /logout(.:format)  
GET    /account(.:format)  
GET    /register(.:format)  
GET    /home(.:format)  
GET    /(.:format)  


## Example API Requests

### Login

Send a POST request to:
	
	http://localhost:3000/login.json?email=test@test.com&password=1234
	
You will be returned a JSON object such as:  
  
	{  
		"scope": {  
		},  
		"remember_me": "1",   
		"invalid_password": false,   
		"new_session": false,  
		"attempted_record": {  
			"user": {  
				"created_at": "2011-02-03T22:23:49Z",   
				"last_request_at": "2011-02-07T23:45:33Z",   
				"single_access_token": "jOvcIBs7ASIEm0w8Vy",  
				"crypted_password":   "66ef6c2b1f59c7ee76a09239764d48786839ee9382b0075becf8b89db87504f8aa36aacd0d473e5345cadb09d9f2dbb9cf8684d9aad6cb07e6a125762f79e523",   
				"perishable_token": "gPgEc6b8D9esiuQHZiO",   
				"updated_at": "2011-02-07T23:45:33Z",   
				"current_login_ip": "127.0.0.1",   
				"failed_login_count": 0,   
				"id": 6,   
				"current_login_at": "2011-02-07T23:45:33Z",   
				"password_salt": "UwIf3BhJeQyCFkYPgfIv",    
				"last_name": "test",   
				"login_count": 17,   
				"persistence_token":   "3156e8e6a9342cc41888efb0c02163e88a18ba81bad49fe2f7906e785bbaba0965242c44a0ba7a2f60e1e440c1f5390f834124f062aa89c81a3bedf89e5465ad",   
				"last_login_ip": "127.0.0.1",   
				"last_login_at": "2011-02-07T23:41:15Z",   
				"email": "test@test.com",   
				"first_name": "test"  
			}   
		},    
		"errors": {   
		},    
		"password": "1234",   
		"record": {   
			"user": {   
				"created_at": "2011-02-03T22:23:49Z",   
				"last_request_at": "2011-02-07T23:45:33Z",    
				"single_access_token": "jOvcIBs7ASIEm0w8Vy",    
				"crypted_password":    "66ef6c2b1f59c7ee76a09239764d48786839ee9382b0075becf8b89db87504f8aa36aacd0d473e5345cadb09d9f2dbb9cf8684d9aad6cb07e6a125762f79e523",   
				"perishable_token": "gPgEc6b8D9esiuQHZiO",   
				"updated_at": "2011-02-07T23:45:33Z",   
				"current_login_ip": "127.0.0.1",   
				"failed_login_count": 0,    
				"id": 6,    
				"current_login_at": "2011-02-07T23:45:33Z",     
				"password_salt": "UwIf3BhJeQyCFkYPgfIv",    
				"last_name": "test",    
				"login_count": 17,   
				"persistence_token":    "3156e8e6a9342cc41888efb0c02163e88a18ba81bad49fe2f7906e785bbaba0965242c44a0ba7a2f60e1e440c1f5390f834124f062aa89c81a3bedf89e5465ad",   
				"last_login_ip": "127.0.0.1",   
				"last_login_at": "2011-02-07T23:41:15Z",   
				"email": "test@test.com",   
				"first_name": "test"  
			}   
		},   
		"email": "test@test.com"  
	}


From this token, you will need to store the user_id and the persistence_token

### List all sights

	http://localhost:3000/sights.json
	
Sample return:  
	
	[  
		{  
			"sight": {  
				"name": "test",   
				"radius": 50,   
				"created_at": "2011-02-07T23:54:50Z",   
				"latitude": 1000,   
				"updated_at": "2011-02-07T23:54:50Z",   
				"id": 2,   
				"user_id": 1,   
				"longitude": 1000  
			}  
		},   
		{  
			"sight": {  
				"name": "new sight",   
				"radius": 80,   
				"created_at": "2011-02-07T23:55:26Z",   
				"latitude": 50,   
				"updated_at": "2011-02-07T23:55:26Z",   
				"id": 3,   
				"user_id": 1,    
				"longitude": 35.8  
			}   
		}  
	]  
	
### Get specific sight

	http://localhost:3000/sights/1.json
	
Sample return:  

	{  
		"sight": {  
			"name": "test",   
			"radius": 50,   
			"created_at": "2011-02-07T23:54:50Z",    
			"latitude": 1000,   
			"updated_at": "2011-02-07T23:54:50Z",   
			"id": 2,   
			"user_id": 1,    
			"longitude": 1000  
		}  
	}  