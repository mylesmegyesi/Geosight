class User < ActiveRecord::Base
    has_many :ratings, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_many :tags, :dependent => :destroy
    has_many :photos, :dependent => :destroy
    has_many :sights, :dependent => :destroy
    acts_as_authentic
    
    # A virtual accessor to make the user's name look pretty 
    def user_name
      self.first_name + " " + self.last_name
    end
    
    # Get the currently logged in user from the cookies
    def self.current_user
        UserSession.find.user
    end
end
