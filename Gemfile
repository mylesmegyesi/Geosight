source "http://rubygems.org"

gem "rails", "3.0.4"
gem "paperclip"
gem "authlogic", :git => "git://github.com/jjb/authlogic.git"
gem "exifr"
gem "aws-s3"
gem "geokit-rails3"

group :test, :development do
    gem "ruby-debug"
    gem "sqlite3"
    gem "mongrel"
end

group :production do
    gem "pg"
    gem "rack-ssl"
end
