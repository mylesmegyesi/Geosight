class User < ActiveRecord::Base
    has_many :sights, :dependent => :destroy
    acts_as_authentic { |c| c.validate_email_field = false }
end
