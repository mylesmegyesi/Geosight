ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "authlogic/test_case" # include at the top of test_helper.rb

class ActiveSupport::TestCase
    
    fixtures :all
    
    @@fixture_temp_photos = {}
    @@fixture_temp_photos[:one] = TempPhoto.create({:user_id => 1, :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0089.jpg"))})
    @@fixture_temp_photos[:two] = TempPhoto.create({:user_id => 1, :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg"))})
        
    def temp_photos(index)
        @@fixture_temp_photos[index]
    end
end

class ActionController::TestCase
    setup :activate_authlogic
end
