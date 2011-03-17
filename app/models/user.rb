class User < ActiveRecord::Base
    has_many :sights, :dependent => :destroy
    has_many :sight_ratings, :dependent => :destroy
    has_many :sight_comments, :dependent => :destroy
    has_many :photos, :dependent => :destroy
    has_many :photo_tags, :dependent => :destroy
    has_many :photo_comments, :dependent => :destroy
    acts_as_authentic
end
