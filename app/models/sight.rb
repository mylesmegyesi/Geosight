class Sight < ActiveRecord::Base
    belongs_to :user
    has_many :photos, :dependent => :destroy
    has_many :sight_comments, :dependent => :destroy
    has_many :sight_ratings, :dependent => :destroy
    validates_presence_of :user_id, :name
    validates_associated :user
    validates_length_of :name, :maximum => 20
    validates_numericality_of :latitude
    validates_numericality_of :longitude
    validates_numericality_of :radius, :less_than_or_equal_to => 100 # max 100 meter radius
    
    def self.possible_sights(latitude, longitude)
        Sight.where("((latitude - ?)*(latitude - ?))-((longitude - ?)*(longitude - ?)) <= radius",
            latitude, latitude, longitude, longitude)
    end
end
