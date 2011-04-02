class User < ActiveRecord::Base
    has_many :ratings, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_many :tags, :dependent => :destroy
    has_many :photos, :dependent => :destroy
    has_many :sights, :dependent => :destroy
    acts_as_authentic
    
    def user_name
      self.first_name + " " + self.last_name
    end
end
