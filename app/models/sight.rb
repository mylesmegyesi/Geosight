class Sight < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :sightcomments
  has_many :ratings
end
