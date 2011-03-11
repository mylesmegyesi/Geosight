ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "authlogic/test_case" # include at the top of test_helper.rb

class ActiveSupport::TestCase
    
    fixtures :all
    
end

class ActionController::TestCase
    setup :activate_authlogic
end
