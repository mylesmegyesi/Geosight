# Geosight

Geosight combines the adventure of geocaching with the art of photography using upcoming photo geotagging technology. Traditional geocaching involves writing in a log book at each cache location. Geosight involves taking a photo at each 'sight' location, encouraging interesting and beautiful 'sights'. Geosight will harness EXIF GPS data included in photos taken by modern digitial cameras and mobile phones.

## Requirements

* Ruby 1.8.7
* RubyGems 1.3.7
* SQLite3
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